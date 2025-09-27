import 'package:flutter/material.dart';

class AnimatedSizeAndFade extends StatefulWidget {
  final bool expanded;
  final Widget child;

  const AnimatedSizeAndFade({
    super.key,
    required this.expanded,
    required this.child,
  });

  @override
  State<AnimatedSizeAndFade> createState() => _AnimatedSizeAndFadeState();
}

class _AnimatedSizeAndFadeState extends State<AnimatedSizeAndFade>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedSizeAndFade oldWidget) {
    if (oldWidget.expanded != widget.expanded) {
      if (widget.expanded) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: animation,
      child: FadeTransition(opacity: animation, child: widget.child),
    );
  }
}
