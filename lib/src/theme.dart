import 'package:flutter/material.dart';

/// An InheritedWidget that provides theme data for skeleton loading animations.
///
/// This widget allows you to define a common theme for all skeleton widgets within its subtree. It provides properties for customizing the shimmer gradient colors in both light and dark modes, as well as an option to override the app's theme mode for the skeleton widgets.
///
/// Typically, you would wrap your entire app or a specific section of your app with a `SkeletonTheme` widget to apply consistent styling to all skeleton animations.
///
/// Example usage:
///
/// ```dart
/// SkeletonTheme(
///   shimmerGradient: LinearGradient(...), // Custom gradient for light mode
///   darkShimmerGradient: LinearGradient(...), // Custom gradient for dark mode
///   themeMode: ThemeMode.light, // Force light mode for skeleton animations
///   child: MyApp(), // Your app's main widget tree
/// )
/// ```
class SkeletonTheme extends InheritedWidget {
  final LinearGradient? shimmerGradient;
  final LinearGradient? darkShimmerGradient;
  final ThemeMode? themeMode;

  const SkeletonTheme({
    super.key,
    required super.child,
    this.shimmerGradient,
    this.darkShimmerGradient,
    this.themeMode,
  });

  static SkeletonTheme? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SkeletonTheme>();

  @override
  bool updateShouldNotify(SkeletonTheme oldWidget) =>
      oldWidget.themeMode != themeMode ||
      oldWidget.shimmerGradient != shimmerGradient ||
      oldWidget.darkShimmerGradient != darkShimmerGradient;
}
