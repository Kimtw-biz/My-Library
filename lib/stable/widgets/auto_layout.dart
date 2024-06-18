import 'package:flutter/widgets.dart';

class AutoLayout extends StatelessWidget {
  const AutoLayout._({
    super.key,
    required this.direction,
    required this.mainAxisGap,
    required this.padding,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.crossAxisAlignment,
    required this.textDirection,
    required this.verticalDirection,
    required this.textBaseline,
    required this.children,
  });

  const AutoLayout.vertical({
    Key? key,
    double mainAxisGap = 0.0,
    EdgeInsets padding = EdgeInsets.zero,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    required List<Widget> children,
  }) : this._(
          key: key,
          direction: Axis.vertical,
          mainAxisGap: mainAxisGap,
          padding: padding,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children,
        );

  const AutoLayout.horizontal({
    Key? key,
    double mainAxisGap = 0.0,
    EdgeInsets padding = EdgeInsets.zero,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    required List<Widget> children,
  }) : this._(
          key: key,
          direction: Axis.horizontal,
          mainAxisGap: mainAxisGap,
          padding: padding,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children,
        );

  final Axis direction;
  final EdgeInsets padding;
  final double mainAxisGap;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Flex(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: switch (children.isNotEmpty) {
          true => _applyMainAxisGap(),
          _ => children,
        },
      ),
    );
  }

  List<Widget> _applyMainAxisGap() => List.generate(children.length, (index) {
        final EdgeInsets padding = switch (direction) {
          Axis.horizontal => switch (textDirection) {
              TextDirection.ltr || null when index < children.length - 1 => EdgeInsets.only(
                  right: mainAxisGap,
                ),
              TextDirection.rtl when index < children.length - 1 => EdgeInsets.only(
                  left: mainAxisGap,
                ),
              _ => EdgeInsets.zero,
            },
          Axis.vertical => switch (verticalDirection) {
              VerticalDirection.down when index < children.length - 1 => EdgeInsets.only(
                  bottom: mainAxisGap,
                ),
              VerticalDirection.up when index < children.length - 1 => EdgeInsets.only(
                  top: mainAxisGap,
                ),
              _ => EdgeInsets.zero,
            },
        };

        return switch (children[index].runtimeType) {
          Flexible => Flexible(
              key: children[index].key,
              flex: (children[index] as Flexible).flex,
              fit: (children[index] as Flexible).fit,
              child: Padding(
                padding: padding,
                child: (children[index] as Flexible).child,
              ),
            ),
          Expanded => Expanded(
              key: children[index].key,
              flex: (children[index] as Expanded).flex,
              child: Padding(
                padding: padding,
                child: (children[index] as Flexible).child,
              ),
            ),
          _ => Padding(
              key: children[index].key,
              padding: padding,
              child: children[index],
            )
        };
      });
}
