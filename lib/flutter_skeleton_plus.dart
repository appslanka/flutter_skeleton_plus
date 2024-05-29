/// A Flutter package for creating visually appealing skeleton loading animations.
///
/// This package provides a set of easy-to-use widgets and utilities to create shimmering skeleton placeholders while your app's content is loading.
/// It includes customizable components for avatars, lines, paragraphs, list tiles, and even entire list views, allowing you to create loading states that match your app's design.
///
/// Key features:
/// - Customizable shimmer gradients for light and dark themes.
/// - Skeleton widgets for various UI elements.
/// - Easy integration with existing widgets.
/// - Theme support for consistent styling.
///
/// To get started, simply import this library and use the provided skeleton widgets in your layouts.
///
/// Example usage:
/// ```dart
/// import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
///
/// // ...
///
/// Skeleton(
///   isLoading: true,
///   skeleton: SkeletonListTile(), // Use the SkeletonListTile widget
///   child: ListTile( /* Your actual list tile content */),
/// )
/// ```
library flutter_skeleton_plus;

export './src/shimmer.dart';
export './src/stylings.dart';
export './src/theme.dart';
export './src/widgets.dart';
