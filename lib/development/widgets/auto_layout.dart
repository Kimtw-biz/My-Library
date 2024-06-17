import 'package:flutter/widgets.dart';

//TODO :: Add Wrap Axis Gap

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
    required this.crossAxisCount,
    required this.wrapMainAxisAlignment,
    required this.wrapCrossAxisAlignment,
    required this.children,
  }) : assert(crossAxisCount >= 0);

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
    int crossAxisCount = 0,
    MainAxisAlignment wrapMainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment wrapCrossAxisAligment = CrossAxisAlignment.center,
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
          crossAxisCount: crossAxisCount,
          wrapMainAxisAlignment: wrapMainAxisAlignment,
          wrapCrossAxisAlignment: wrapCrossAxisAligment,
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
    int crossAxisCount = 0,
    MainAxisAlignment wrapMainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment wrapCrossAxisAligment = CrossAxisAlignment.center,
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
          crossAxisCount: crossAxisCount,
          wrapMainAxisAlignment: wrapMainAxisAlignment,
          wrapCrossAxisAlignment: wrapCrossAxisAligment,
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

  final int crossAxisCount;
  final MainAxisAlignment wrapMainAxisAlignment;
  final CrossAxisAlignment wrapCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = switch (this.children.isNotEmpty) {
      true => _applyMainAxisGap(),
      _ => this.children,
    };

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
        children: switch (crossAxisCount) {
          0 => children,
          _ => List.generate(
              (children.length / crossAxisCount).ceil(),
              (i) => Flex(
                direction: switch (direction) {
                  Axis.horizontal => Axis.vertical,
                  Axis.vertical => Axis.horizontal,
                },
                mainAxisAlignment: wrapMainAxisAlignment,
                crossAxisAlignment: wrapCrossAxisAlignment,
                children: List.generate(
                  crossAxisCount,
                  (j) {
                    final int index = i * crossAxisCount + j;

                    if (index >= children.length) {
                      return const Flexible(child: SizedBox());
                    } else {
                      return children[index];
                    }
                  },
                ),
              ),
            ),
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
