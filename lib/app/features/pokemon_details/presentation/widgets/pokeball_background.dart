import 'package:flutter/material.dart';

class PokeballBackground extends StatefulWidget {
  final double? size;
  const PokeballBackground({super.key, this.size});

  @override
  State<PokeballBackground> createState() => _PokeballBackgroundState();
}

class _PokeballBackgroundState extends State<PokeballBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        'assets/images/logo.png',
        height: widget.size ?? size.height * 0.3,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}
