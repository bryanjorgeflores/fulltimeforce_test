import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/widgets/pokemon_tile.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';

class PokemonFavoriteList extends StatelessWidget {
  final List<Pokemon> pokemons;
  const PokemonFavoriteList({super.key, required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        final Pokemon pokemon = pokemons[index];
        return PokemonTile(pokemon: pokemon);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}
