import 'package:flutter/cupertino.dart';

class HeartAnimationWidget extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;


  const HeartAnimationWidget.name({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150)
}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimationWidget> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> scale;


  @override
  void initState() {
    super.initState();

    final halfDuration = widget.duration.inMilliseconds;
    controller = AnimationController(
        vsync: this,
      duration: Duration(milliseconds: halfDuration)
    );

    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }


  @override
  void didUpdateWidget(HeartAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      doAnimation();
    }
  }

  Future doAnimation() async {
    await controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: scale,
      child: widget.child);

}