import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

@Deprecated("This widget is deprecated. Use ExSpacer instead.")
class VoidSpace extends SingleChildRenderObjectWidget {
  const VoidSpace({
    super.key,
    this.width,
    this.height,
  });

  const VoidSpace.vertical(double value, {super.key})
      : width = 0.0,
        height = value;

  const VoidSpace.horizontal(double value, {super.key})
      : width = value,
        height = 0.0;

  const VoidSpace.expand({super.key})
      : width = double.infinity,
        height = double.infinity;

  const VoidSpace.shrink({super.key})
      : width = 0.0,
        height = 0.0;

  VoidSpace.fromSize({super.key, Size? size})
      : width = size?.width,
        height = size?.height;

  const VoidSpace.square({super.key, double? dimension})
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
      type = '${objectRuntimeType(this, 'VoidSpace')}.expand';
    } else if (width == 0.0 && height == 0.0) {
      type = '${objectRuntimeType(this, 'VoidSpace')}.shrink';
    } else {
      type = objectRuntimeType(this, 'VoidSpace');
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
