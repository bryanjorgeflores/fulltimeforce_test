import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/enums/pokemon_colors_enum.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/presentation/cubit/pokemon_cubit.dart';
import 'package:intl/intl.dart';

class PokemonDetailsHeader extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetailsHeader({super.key, required this.pokemon});

  int calculateCP() {
    int combatPower = pokemon.stats!
        .fold(0, (previousValue, element) => previousValue + element.baseStat!);
    return combatPower;
  }

  void _onDeletePokemon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Pokemon'),
          content: const Text(
            'Are you sure you want to delete this pokemon from your favorites?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final pokemonCubit = context.read<PokemonCubit>();
                pokemonCubit.deletePokemon(pokemon);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        final isFavorite = state.cache.pokemons
            .where((element) => element.id == pokemon.id)
            .isNotEmpty;
        final PokemonColors color = PokemonColors.values.firstWhere(
          (element) => element.code == pokemon.types!.first.type!.name,
        );
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: color.contrastColor,
                  size: 30,
                ),
              ),
              Expanded(
                child: Text(
                  '#${pokemon.id.toString().padLeft(3, '0')} '
                  '${toBeginningOfSentenceCase(pokemon.name)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color.contrastColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  final pokemonCubit = context.read<PokemonCubit>();
                  if (isFavorite) {
                    _onDeletePokemon(context);
                  } else {
                    pokemonCubit.savePokemon(pokemon);
                  }
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: color.contrastColor,
                ),
                iconSize: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
