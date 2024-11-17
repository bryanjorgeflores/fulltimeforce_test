import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/enums/pokemon_colors_enum.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/presentation/cubit/pokemon_cubit.dart';
import 'package:fulltimeforce_test/app/features/pokemon_details/presentation/widgets/header.dart';
import 'package:fulltimeforce_test/app/features/pokemon_details/presentation/widgets/pokeball_background.dart';
import 'package:fulltimeforce_test/app/features/pokemon_details/presentation/widgets/pokemon_card_info.dart';
import 'package:fulltimeforce_test/app/features/pokemon_details/presentation/widgets/pokemon_image.dart';
import 'package:fulltimeforce_test/app/features/pokemon_details/presentation/widgets/power_up.dart';

class PokemonDetailsPage extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetailsPage({super.key, required this.pokemon});

  Color getBackgroundColor() {
    final kind = pokemon.types?.first.type?.name ?? '';
    return PokemonColors.values
        .firstWhere((element) => element.code == kind)
        .color;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                const Positioned(
                  right: -120,
                  top: -100,
                  child: PokeballBackground(
                    size: 350,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        getBackgroundColor().withOpacity(0.5),
                        Color.alphaBlend(
                          getBackgroundColor(),
                          Colors.black,
                        )
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 255],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 20,
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(height: 70),
                      SizedBox(
                        height: 200,
                        child: PokemonImageGallery(
                          pokemon: pokemon,
                        ),
                      ),
                      const SizedBox(height: 20),
                      PokemonCardInfo(
                        pokemon: pokemon,
                      ),
                      const SizedBox(height: 20),
                      PowerUpPokemon(
                        pokemon: pokemon,
                      )
                    ],
                  ),
                ),
                PokemonDetailsHeader(
                  pokemon: pokemon,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
