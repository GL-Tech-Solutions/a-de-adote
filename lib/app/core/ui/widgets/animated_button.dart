import 'package:flutter/material.dart';
import '../../constants/buttons.dart';
import '../styles/project_colors.dart';
import '../styles/project_fonts.dart';

class AnimatedButton extends StatefulWidget {
  final Function()? route;

  const AnimatedButton({super.key, required this.route});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.duration = const Duration(milliseconds: 700);
    _controller.forward();

    _animation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        hoverColor: ProjectColors.primaryDark,
        onTap: widget.route,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.5),
          decoration: const BoxDecoration(
            color: ProjectColors.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                Buttons.vamosComecar,
                style: ProjectFonts.pLightBold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
