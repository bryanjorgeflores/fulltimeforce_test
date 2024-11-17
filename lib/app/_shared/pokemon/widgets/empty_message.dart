import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/features/pokemon_details/presentation/widgets/pokeball_background.dart';

class EmptyMessage extends StatelessWidget {
  final String message;
  const EmptyMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PokeballBackground(),
        const SizedBox(height: 10),
        Text(
          message,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
