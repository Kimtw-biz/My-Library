import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ExSpacer extends SingleChildRenderObjectWidget {
  const ExSpacer({
    super.key,
    this.width,
    this.height,
  });

  const ExSpacer.vertical(double value, {super.key})
      : width = 0.0,
        height = value;

  const ExSpacer.horizontal(double value, {super.key})
      : width = value,
        height = 0.0;

  const ExSpacer.expand({super.key})
      : width = double.infinity,
        height = double.infinity;

  const ExSpacer.shrink({super.key})
      : width = 0.0,
        height = 0.0;

  ExSpacer.fromSize({super.key, Size? size})
      : width = size?.width,
        height = size?.height;

  const ExSpacer.square({super.key, double? dimension})
      : width = dimension,
        height = dimension;

  final double? width;

  final double? height;

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      additionalConstraints: _additionalConstraints,
    );
  }

  BoxConstraints get _additionalConstraints {
    return BoxConstraints.tightFor(width: width, height: height);
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox renderObject) {
    renderObject.additionalConstraints = _additionalConstraints;
  }

  @override
  String toStringShort() {
    final String type;
    if (width == double.infinity && height == double.infinity) {
      type = '${objectRuntimeType(this, 'ExSpacer')}.expand';
    } else if (width == 0.0 && height == 0.0) {
      type = '${objectRuntimeType(this, 'ExSpacer')}.shrink';
    } else {
      type = objectRuntimeType(this, 'ExSpacer');
    }
    return key == null ? type : '$type-$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final DiagnosticLevel level;
    if ((width == double.infinity && height == double.infinity) || (width == 0.0 && height == 0.0)) {
      level = DiagnosticLevel.hidden;
    } else {
      level = DiagnosticLevel.info;
    }
    properties.add(DoubleProperty('width', width, defaultValue: null, level: level));
    properties.add(DoubleProperty('height', height, defaultValue: null, level: level));
  }
}
