// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/enums/pokemon_colors_enum.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/widgets/toast.dart';
import 'package:fulltimeforce_test/app/features/pokemon_details/presentation/widgets/pokemon_card_moves.dart';
import 'package:just_audio/just_audio.dart';

class PokemonCardInfo extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonCardInfo({super.key, required this.pokemon});

  @override
  State<PokemonCardInfo> createState() => _PokemonCardInfoState();
}

class _PokemonCardInfoState extends State<PokemonCardInfo> {
  AudioPlayer player = AudioPlayer();

  void playCry() async {
    try {
      if (player.playing) {
        await player.stop();
      }
      final cry = widget.pokemon.cries?.latest ?? widget.pokemon.cries?.legacy;
      if (cry != null && cry.isNotEmpty) {
        await player.setUrl(cry);
        await player.play();
      } else {
        Toast.show(context, 'No cry available');
      }
    } catch (e) {
      Toast.show(context, 'Failed to play cry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.3),
        border: Border.all(
          color: PokemonColors.values
              .firstWhere(
                (element) =>
                    element.code == widget.pokemon.types!.first.type!.name,
              )
              .contrastColor,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    '${(widget.pokemon.weight! / 10).toString()} KG',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'WEIGHT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (PokemonType kind in widget.pokemon.types!)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Color.alphaBlend(
                                  PokemonColors.values
                                      .firstWhere((element) =>
                                          element.code == kind.type!.name)
                                      .color,
                                  Colors.black12,
                                ),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.pokemon.types?.map((e) => e.type?.name?.toUpperCase()).join(' / ')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '${(widget.pokemon.height! / 10).toString()} M',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'HEIGHT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: playCry,
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.volume_up,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Play',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/candy.png',
                        height: 20,
                        color: PokemonColors.values
                            .firstWhere((element) =>
                                element.code ==
                                widget.pokemon.types!.first.type!.name)
                            .color,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '16',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${widget.pokemon.name?.toUpperCase()} CANDY',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          PokemonCardMoves(
            pokemon: widget.pokemon,
          ),
        ],
      ),
    );
  }
}
