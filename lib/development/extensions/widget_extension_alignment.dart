import 'package:flutter/widgets.dart';

extension WidgetExtensionAlignment on Widget {
  Widget align(Alignment value, {double? widthFactor, double? heightFactor}) {
    return Align(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  Widget alignCenter({double? widthFactor, double? heightFactor}) {
    return Align(
      alignment: Alignment.center,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }
}
