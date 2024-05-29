part of 'widgets.dart';

/*
thanks to: https://flutter.dev/docs/cookbook/effects/shimmer-loading
*/

/// A StatefulWidget that conditionally displays either a loading skeleton or its actual child widget.
///
/// [isLoading] determines whether to show the skeleton or the child.
/// [skeleton] is the widget to display during loading.
/// [child] is the actual content widget.
/// The optional parameters [shimmerGradient], [darkShimmerGradient], [duration], and [themeMode] allow customization of the shimmer effect used in the skeleton.
class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    required this.isLoading,
    required this.skeleton,
    required this.child,
    this.shimmerGradient,
    this.darkShimmerGradient,
    this.duration,
    this.themeMode,
  });

  final bool isLoading;
  final Widget skeleton;
  final Widget child;
  final LinearGradient? shimmerGradient;
  final LinearGradient? darkShimmerGradient;
  final Duration? duration;
  final ThemeMode? themeMode;

  @override
  _SkeletonState createState() => _SkeletonState();
}

/// Manages the state of the [Skeleton] widget, animating the transition between loading and loaded states.
class _SkeletonState extends State<Skeleton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: widget.isLoading
          ? ShimmerWidget(
              shimmerGradient: widget.shimmerGradient,
              darkShimmerGradient: widget.darkShimmerGradient,
              duration: widget.duration,
              themeMode: widget.themeMode,
              child: _SkeletonWidget(
                isLoading: widget.isLoading,
                // child: widget.child,
                skeleton: widget.skeleton,
              ),
            )
          : widget.child,
    );
  }
}

/// A StatefulWidget that builds the visual representation of the loading skeleton.
///
/// [isLoading] indicates whether the skeleton should be displayed.
/// [skeleton] is the widget tree that defines the appearance of the skeleton.
class _SkeletonWidget extends StatefulWidget {
  const _SkeletonWidget({
    required this.isLoading,
    required this.skeleton,
    // required this.child,
  });

  final bool isLoading;
  final Widget skeleton;
  // final Widget child;

  @override
  __SkeletonWidgetState createState() => __SkeletonWidgetState();
}

/// Manages the state of the [_SkeletonWidget], updating the shimmer effect during loading.
class __SkeletonWidgetState extends State<_SkeletonWidget> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  /// Callback triggered when the shimmer animation changes.
  ///
  /// This method forces a rebuild of the [_SkeletonWidget] if it's currently in the loading state.
  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // update the shimmer painting.
      });
    }
  }

  /// Builds the visual representation of the loading skeleton.
  ///
  /// This method creates a [ShaderMask] that applies the shimmer gradient to the [skeleton] widget, simulating a loading effect. If the skeleton isn't loading, it returns the [child] widget instead.
  @override
  Widget build(BuildContext context) {
    // Collect ancestor shimmer info.
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      // The ancestor Shimmer widget has not laid
      // itself out yet. Return an empty box.
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.currentGradient;

    if (context.findRenderObject() == null) return const SizedBox();

    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.skeleton,
    );
  }
}
