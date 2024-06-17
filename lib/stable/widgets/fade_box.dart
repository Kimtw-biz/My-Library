import 'package:flutter/widgets.dart';

//TODO Add transition
//TODO Add repeat and reverse
//TODO Add lower/upper bounds
//TODO Add begin/end values

class FadeBox extends StatefulWidget {
  const FadeBox({
    super.key,
    this.curve,
    this.duration,
    this.onAnimation,
    this.onAnimationStatus,
    this.child,
  });

  final Curve? curve;
  final Duration? duration;

  final void Function()? onAnimation;
  final void Function(AnimationStatus status)? onAnimationStatus;

  final Widget? child;

  @override
  State<FadeBox> createState() => _FadeBoxState();
}

class _FadeBoxState extends State<FadeBox> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ??
          const Duration(
            milliseconds: 1000,
          ),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve ?? Curves.easeInOut,
    ));

    _controller.addListener(
      () => setState(() => widget.onAnimation?.call()),
    );

    _controller.addStatusListener(
      (status) => widget.onAnimationStatus?.call(status),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
