import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/enums/pokemon_colors_enum.dart';
import 'package:intl/intl.dart';

class PokemonCardMoves extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCardMoves({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final moves = pokemon.moves ?? [];
    final displayedMoves = moves.take(6).toList();
    final kind = pokemon.types?.first.type?.name ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MOVES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: displayedMoves.map((move) {
            return Chip(
              side: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
              label: Text(
                toBeginningOfSentenceCase(move.move?.name) ?? '',
                style: TextStyle(
                  color: PokemonColors.values
                      .firstWhere((element) => element.code == kind)
                      .contrastColor,
                  fontSize: 12,
                ),
              ),
              backgroundColor: Color.alphaBlend(
                PokemonColors.values
                    .firstWhere((element) => element.code == kind)
                    .color,
                Colors.black12,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
