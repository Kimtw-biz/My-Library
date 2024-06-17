import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum LineStyle { dash, dot, solid, custom }

class Line extends StatefulWidget {
  const Line._(
    this.style,
    this.thickness,
    this.color, {
    super.key,
  });

  const Line.dash({
    Key? key,
    double thickness = 1.0,
    Color color = const Color(0xFF000000),
  }) : this._(LineStyle.dash, thickness, color, key: key);

  const Line.dot({
    Key? key,
    double thickness = 1.0,
    Color color = const Color(0xFF000000),
  }) : this._(LineStyle.dot, thickness, color, key: key);

  final LineStyle style;
  final double? thickness;
  final Color color;

  @override
  State<Line> createState() => _LineState();
}

class _LineState extends State<Line> {
  final GlobalKey _key = GlobalKey();

  Offset p0 = Offset.zero;
  Offset p1 = Offset.zero;

  Size? get _size => (_key.currentContext?.findRenderObject() as RenderBox?)?.size;
  Offset? get _offset => (_key.currentContext?.findRenderObject() as RenderBox?)?.localToGlobal(Offset.zero);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    debugPrint("$_size");
    debugPrint("$_offset");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double dy = (_size?.height)! * 0.5;

      setState(() {
        p0 = Offset(0.0, dy);
        p1 = Offset((_size?.width)!, dy);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class DottedLinePainter extends CustomPainter {
  const DottedLinePainter(
    this.p0,
    this.p1,
    this.width,
    this.color,
  );

  final Offset p0;
  final Offset p1;

  final double width;

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      p0,
      p1,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = const Color(0xFF000000),
    );

    // TODO: implement paint
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => true;
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const RadialGradient gradient = RadialGradient(
      center: Alignment(0.7, -0.6),
      radius: 0.2,
      colors: <Color>[Color(0xFFFFFF00), Color(0xFF0099FF)],
      stops: <double>[0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      Rect rect = Offset.zero & size;
      final double width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return <CustomPainterSemantics>[
        CustomPainterSemantics(
          rect: rect,
          properties: const SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(Sky oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}
