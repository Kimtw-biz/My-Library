import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

//TODO::Feature Primary controller
//TODO::Feature Inverse fill direction
//TODO::Feature Background Image
//TODO::Feature Foreground Image
//TODO::Feature Foreground Mask
//TODO::Feature Circular Progress Bar

class ScrollProgressBar extends StatefulWidget {
  const ScrollProgressBar({
    super.key,
    required this.controller,
    this.direction = Axis.horizontal,
    this.thickness = 4.0,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.foregroundColor = const Color(0xFF2196F3),
    this.duration = const Duration(milliseconds: 75),
    this.curve = Curves.easeInOut,
  });

  final ScrollController controller;
  final Axis direction;
  final double thickness;
  final Color backgroundColor;
  final Color foregroundColor;
  final Duration duration;
  final Curve curve;

  @override
  State<ScrollProgressBar> createState() => _ScrollProgressBarState();
}

class _ScrollProgressBarState extends State<ScrollProgressBar> {
  double maxIndicatorSize = 0.0;
  double indicatorSize = 0.0;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (mounted) {
        _updateIndicatorSize();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateMaxIndicatorSize();
        _updateIndicatorSize();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: _onSizeChangedNotification,
      child: SizeChangedLayoutNotifier(
        child: Stack(
          children: [
            Container(
              width: switch (widget.direction) {
                Axis.horizontal => double.maxFinite,
                Axis.vertical || _ => widget.thickness,
              },
              height: switch (widget.direction) {
                Axis.horizontal => widget.thickness,
                Axis.vertical || _ => double.maxFinite,
              },
              color: widget.backgroundColor,
              child: const SizedBox.expand(),
            ),
            AnimatedContainer(
              width: switch (widget.direction) {
                Axis.horizontal => indicatorSize,
                Axis.vertical || _ => widget.thickness,
              },
              height: switch (widget.direction) {
                Axis.horizontal => widget.thickness,
                Axis.vertical || _ => indicatorSize,
              },
              color: widget.foregroundColor,
              duration: widget.duration,
              curve: widget.curve,
            )
          ],
        ),
      ),
    );
  }

  bool _onSizeChangedNotification(SizeChangedLayoutNotification notification) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateMaxIndicatorSize();
        _updateIndicatorSize();
      }
    });

    return false;
  }

  void _updateMaxIndicatorSize() {
    if (context.size == null || widget.controller.positions.isEmpty) return;

    final double contextWidth = context.size!.width;
    final double contextHeight = context.size!.height;

    setState(() {
      maxIndicatorSize = switch (widget.direction) {
        Axis.horizontal => contextWidth,
        Axis.vertical || _ => contextHeight,
      };
    });
  }

  void _updateIndicatorSize() {
    if (maxIndicatorSize <= 0.0) return;

    //if scroll max extent is 0 and  current position is 0  then set value to 1?

    final double maxScrollExtent = widget.controller.position.maxScrollExtent;
    final double curScrollPosition = widget.controller.position.pixels;

    final double curScrollPositionNormalized = switch (maxScrollExtent <= 0.0 || curScrollPosition <= 0.0) {
      false => (curScrollPosition / maxScrollExtent).clamp(0, 1),
      true => 0.0,
    };

    setState(() {
      indicatorSize = maxIndicatorSize * curScrollPositionNormalized;
    });
  }
}
