import 'package:flutter/material.dart';

class TaskCheckbox extends StatefulWidget {
  final VoidCallback? onToggle;
  final bool completed;
  final bool failure;

  const TaskCheckbox({
    super.key,
    this.completed = false,
    this.failure = false,
    this.onToggle,
  });

  @override
  State<TaskCheckbox> createState() => _TaskCheckboxState();
}

class _TaskCheckboxState extends State<TaskCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  IconData get _icon {
    if (widget.completed) return Icons.check_circle;
    if (widget.failure) return Icons.cancel;
    return Icons.radio_button_unchecked;
  }

  Color get _color {
    if (widget.completed) return Colors.green;
    if (widget.failure) return Colors.red;
    return Colors.grey;
  }

  void _animateIcon() {
    _controller.forward().then((_) => _controller.reverse());
  }

  void _handleTap() {
    widget.onToggle?.call();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 220),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void didUpdateWidget(TaskCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.completed != oldWidget.completed ||
        widget.failure != oldWidget.failure) {
      _animateIcon();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: _handleTap,
      child: SizedBox(
        width: 32,
        height: 32,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Icon(_icon, color: _color, size: 24.0),
          ),
        ),
      ),
    );
  }
}
