import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/enums/pokemon_colors_enum.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/presentation/cubit/pokemon_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class PokemonTile extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonTile({super.key, required this.pokemon});

  @override
  State<PokemonTile> createState() => _PokemonTileState();
}

class _PokemonTileState extends State<PokemonTile> {
  void _onDeletePokemon() {
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
                pokemonCubit.deletePokemon(widget.pokemon);
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
    String pokemonKind = PokemonColors.normal.code;
    if ((widget.pokemon.types?.isNotEmpty ?? false) &&
        widget.pokemon.types?.first.type?.name != null) {
      pokemonKind = widget.pokemon.types!.first.type!.name!;
    }

    PokemonColors pokemonColor = PokemonColors.values
        .firstWhere((element) => element.code == pokemonKind);

    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        final isFavorite = state.cache.pokemons
            .where((element) => element.id == widget.pokemon.id)
            .isNotEmpty;
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            await Navigator.pushNamed(
              context,
              '/pokemon-details',
              arguments: widget.pokemon,
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned(
                right: -45,
                top: -45,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 240,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Ink(
                height: 120,
                decoration: BoxDecoration(
                  color: PokemonColors.values
                      .firstWhere((element) => element.code == pokemonKind)
                      .color
                      .withOpacity(0.75),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: pokemonColor.contrastColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              toBeginningOfSentenceCase(
                                  widget.pokemon.name ?? ''),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: pokemonColor.contrastColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      CachedNetworkImage(
                        imageUrl: '${widget.pokemon.sprites?.officialArtwork}',
                        progressIndicatorBuilder: (context, url, progress) =>
                            Lottie.asset(
                          'assets/json/loading.json',
                          height: 100,
                        ),
                        errorWidget: (context, error, stackTrace) {
                          return Image.asset('assets/images/whosthat.png');
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 18,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (PokemonType kind in widget.pokemon.types!)
                      Container(
                        width: 75,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        margin: const EdgeInsets.only(
                          right: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color.alphaBlend(
                            PokemonColors.values
                                .firstWhere((element) =>
                                    element.code == kind.type!.name)
                                .color,
                            Colors.black12,
                          ),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            toBeginningOfSentenceCase(kind.type!.name ?? ''),
                            style: TextStyle(
                              color: PokemonColors.values
                                  .firstWhere((element) =>
                                      element.code == kind.type!.name)
                                  .contrastColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: pokemonColor.contrastColor,
                  ),
                  onPressed: () {
                    final pokemonCubit = context.read<PokemonCubit>();
                    if (isFavorite) {
                      _onDeletePokemon();
                    } else {
                      pokemonCubit.savePokemon(widget.pokemon);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
