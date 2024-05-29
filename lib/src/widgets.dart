import 'dart:math';
import 'package:flutter/material.dart';
import 'shimmer.dart';
import 'stylings.dart';

part 'skeleton.dart';

/// A wrapper widget that displays either its child widget or a [ShimmerWidget] with the child as a skeleton if a [Shimmer] ancestor is found.
///
/// This widget is useful for creating loading states where you want to show a placeholder (skeleton) of the child widget while it's being fetched.
class SkeletonItem extends StatelessWidget {
  final Widget child;
  const SkeletonItem({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    if (Shimmer.of(context) == null) {
      return ShimmerWidget(
        child: _SkeletonWidget(
          isLoading: true, skeleton: child,
          //  child: SizedBox()
        ),
      );
    }

    return child;
  }
}

/// A skeleton widget that represents a circular or rectangular avatar placeholder.
///
/// The [style] property can be used to customize the appearance of the skeleton avatar, including its width, height, padding, shape, and border radius.
class SkeletonAvatar extends StatelessWidget {
  final SkeletonAvatarStyle style;
  const SkeletonAvatar({super.key, this.style = const SkeletonAvatarStyle()});

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Padding(
        padding: style.padding,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: ((style.randomWidth != null && style.randomWidth!) ||
                      (style.randomWidth == null &&
                          (style.minWidth != null && style.maxWidth != null)))
                  ? doubleInRange(
                      style.minWidth ??
                          ((style.maxWidth ?? constraints.maxWidth) / 3),
                      style.maxWidth ?? constraints.maxWidth)
                  : style.width,
              height: ((style.randomHeight != null && style.randomHeight!) ||
                      (style.randomHeight == null &&
                          (style.minHeight != null && style.maxHeight != null)))
                  ? doubleInRange(
                      style.minHeight ??
                          ((style.maxHeight ?? constraints.maxHeight) / 3),
                      style.maxHeight ?? constraints.maxHeight)
                  : style.height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: style.shape,
                borderRadius:
                    style.shape != BoxShape.circle ? style.borderRadius : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A skeleton widget that represents a single line of text or a similar element.
///
/// The [style] property allows customization of the skeleton line's width, height, padding, length, alignment, and border radius.
class SkeletonLine extends StatelessWidget {
  final SkeletonLineStyle style;
  const SkeletonLine({super.key, this.style = const SkeletonLineStyle()});

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Align(
        alignment: style.alignment,
        child: Padding(
            padding: style.padding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: ((style.randomLength != null && style.randomLength!) ||
                          (style.randomLength == null &&
                              (style.minLength != null &&
                                  style.maxLength != null)))
                      ? doubleInRange(
                          style.minLength ??
                              ((style.maxLength ?? constraints.maxWidth) / 3),
                          style.maxLength ?? constraints.maxWidth)
                      : style.width,
                  height: style.height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: style.borderRadius,
                  ),
                );
              },
            )),
      ),
    );
  }
}

/// A skeleton widget that represents a paragraph of text or similar content.
///
/// The [style] property controls the number of lines, padding, spacing between lines, and the style of each individual line in the skeleton paragraph.
class SkeletonParagraph extends StatelessWidget {
  final SkeletonParagraphStyle style;

  const SkeletonParagraph({
    super.key,
    this.style = const SkeletonParagraphStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Padding(
        padding: style.padding,
        child: Column(
          children: [
            for (var i = 1; i <= style.lines; i++) ...[
              SkeletonLine(
                style: style.lineStyle,
              ),
              if (i != style.lines)
                SizedBox(
                  height: style.spacing,
                )
            ]
          ],
        ),
      ),
    );
  }
}

/// A skeleton widget that represents a list tile, commonly used in lists or data displays.
///
/// This widget can optionally include a leading avatar, a title line, a subtitle line, and trailing content.
/// You can customize its appearance using various properties like `hasLeading`, `leadingStyle`, `titleStyle`, `hasSubtitle`, `subtitleStyle`, `padding`, `contentSpacing`, and `verticalSpacing`.
class SkeletonListTile extends StatelessWidget {
  final bool hasLeading;
  final SkeletonAvatarStyle? leadingStyle;
  final SkeletonLineStyle? titleStyle;
  final bool hasSubtitle;
  final SkeletonLineStyle? subtitleStyle;
  final EdgeInsetsGeometry? padding;
  final double? contentSpacing;
  final double? verticalSpacing;
  final Widget? trailing;

  // final SkeletonListTileStyle style;

  const SkeletonListTile({
    super.key,
    this.hasLeading = true,
    this.leadingStyle, //  = const SkeletonAvatarStyle(padding: EdgeInsets.all(0)),
    this.titleStyle = const SkeletonLineStyle(
      padding: EdgeInsets.all(0),
      height: 22,
    ),
    this.subtitleStyle = const SkeletonLineStyle(
      height: 16,
      padding: EdgeInsetsDirectional.only(end: 32),
    ),
    this.hasSubtitle = false,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.contentSpacing = 8,
    this.verticalSpacing = 8,
    this.trailing,
  });
  // : assert(height >= lineHeight + spacing + (padding?.vertical ?? 16) + 2);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasLeading)
              SkeletonAvatar(
                style: leadingStyle ?? const SkeletonAvatarStyle(),
              ),
            SizedBox(
              width: contentSpacing,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SkeletonLine(
                    style: titleStyle ?? const SkeletonLineStyle(),
                  ),
                  if (hasSubtitle) ...[
                    SizedBox(
                      height: verticalSpacing,
                    ),
                    SkeletonLine(
                      style: subtitleStyle ?? const SkeletonLineStyle(),
                    ),
                  ]
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

/// A skeleton widget that displays a list of items using a [ListView.builder].
///
/// You can provide either a single [item] widget or an [itemBuilder] function to customize the appearance of each item in the list. The [itemCount] specifies the number of items, and the [scrollable] flag determines whether the list can scroll. You can also adjust the [padding] and [spacing] of the items.
class SkeletonListView extends StatelessWidget {
  final Widget? item;
  final Widget Function(BuildContext, int)? itemBuilder;
  final int? itemCount;
  final bool scrollable;
  final EdgeInsets? padding;
  final double? spacing;

  const SkeletonListView({
    super.key,
    this.item,
    this.itemBuilder,
    this.itemCount,
    this.scrollable = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: ListView.builder(
        padding: padding,
        physics: scrollable ? null : const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder ??
            (context, index) =>
                item ??
                const SkeletonListTile(
                  hasSubtitle: true,
                ),
      ),
    );
  }
}

/// Generates a random double value within the specified range.
///
/// This function takes a [start] and [end] value and returns a random double value between them, inclusive.
double doubleInRange(num start, num end) =>
    Random().nextDouble() * (end - start) + start;
