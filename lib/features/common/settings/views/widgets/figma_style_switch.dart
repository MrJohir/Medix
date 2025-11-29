import 'package:flutter/material.dart';

/// Figma-style Custom Switch Widget
/// Based on the provided Figma design with Material-style animations
class FigmaStyleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;

  const FigmaStyleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
  });

  @override
  State<FigmaStyleSwitch> createState() => _FigmaStyleSwitchState();
}

class _FigmaStyleSwitchState extends State<FigmaStyleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _trackColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _trackColorAnimation = ColorTween(
      begin: widget.inactiveColor ?? const Color(0xFFE0E0E0),
      end: widget.activeColor ?? const Color(0xFF1976D2),
    ).animate(_controller);

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FigmaStyleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: SizedBox(
        width: 58,
        height: 38,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                // Track background
                Positioned(
                  left: 0,
                  top: 0,
                  child: Opacity(
                    opacity: 0.50,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 34,
                            height: 14,
                            decoration: ShapeDecoration(
                              color:
                                  _trackColorAnimation.value ??
                                  const Color(0xFF1976D2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Thumb (animated position)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  left: widget.value ? 20 : 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: ShapeDecoration(
                            color: widget.value
                                ? (widget.activeThumbColor ??
                                      const Color(0xFF1976D2))
                                : (widget.inactiveThumbColor ?? Colors.white),
                            shape: const OvalBorder(),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 1,
                                offset: Offset(0, 2),
                                spreadRadius: -1,
                              ),
                              BoxShadow(
                                color: Color(0x23000000),
                                blurRadius: 1,
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Color(0x1E000000),
                                blurRadius: 3,
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
