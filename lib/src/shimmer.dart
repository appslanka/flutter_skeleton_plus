import 'package:flutter/material.dart';

import 'stylings.dart';
import 'theme.dart';

/// A StatefulWidget that creates a shimmering effect, typically used for loading placeholders.
///
/// [shimmerGradient] and [darkShimmerGradient] customize the gradient colors in light and dark themes.
/// [themeMode] lets you override the app's theme to choose the gradient.
/// [duration] controls the animation speed, and [child] is the widget to apply the shimmer effect to.
class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({
    super.key,
    this.shimmerGradient,
    this.darkShimmerGradient,
    this.themeMode,
    this.duration,
    this.child,
  });

  final LinearGradient? shimmerGradient;
  final LinearGradient? darkShimmerGradient;
  final ThemeMode? themeMode;
  final Duration? duration;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

/// Manages the state of the [ShimmerWidget], including the animation controller.
///
/// This class handles the shimmer animation's setup, control, and disposal.
class ShimmerState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  /// Initializes the [ShimmerState].
  ///
  /// This method sets up the animation controller to create the repeating shimmer effect.
  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
          min: -2.0,
          max: 2,
          period: widget.duration ?? const Duration(milliseconds: 1000));
  }

  /// Cleans up resources when the [ShimmerWidget] is disposed.
  ///
  /// Disposes of the animation controller to prevent memory leaks.
  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  /// Gets the appropriate theme mode based on the current context.
  ///
  /// This method checks the app's brightness and the [SkeletonTheme]'s theme mode, falling back to the light theme if neither is available.
  ThemeMode get _appThemeMode => Theme.of(context).brightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;

  @visibleForTesting
  LinearGradient get gradient => ((widget.themeMode ??
              SkeletonTheme.of(context)?.themeMode ??
              _appThemeMode) ==
          ThemeMode.dark)
      ? _darkGradient
      : _lightGradient;

  /// Gets the gradient to use for the shimmer effect.
  ///
  /// This method selects the gradient based on the theme mode, prioritizing the gradients provided in the [ShimmerWidget], the [SkeletonTheme], and finally the default gradients.
  LinearGradient get _lightGradient =>
      widget.shimmerGradient ??
      SkeletonTheme.of(context)?.shimmerGradient ??
      SHIMMER_GRADIENT;

  LinearGradient get _darkGradient =>
      widget.darkShimmerGradient ??
      SkeletonTheme.of(context)?.darkShimmerGradient ??
      DARK_SHIMMER_GRADIENT;

  LinearGradient get currentGradient => LinearGradient(
        colors: gradient.colors,
        stops: gradient.stops,
        begin: gradient.begin,
        end: gradient.end,
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized => context.findRenderObject() != null
      ? (context.findRenderObject() as RenderBox).hasSize
      : false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child != null
        ? Shimmer(
            shimmer: this,
            child: widget.child!,
          )
        : const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class Shimmer extends InheritedWidget {
  final ShimmerState shimmer;
  const Shimmer({
    super.key,
    required super.child,
    required this.shimmer,
  });

  static ShimmerState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Shimmer>()?.shimmer;

  @override
  bool updateShouldNotify(Shimmer oldWidget) => shimmer != oldWidget.shimmer;
}
