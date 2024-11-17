import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/presentation/cubit/pokemon_cubit.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/widgets/empty_message.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/widgets/pokemon_list.dart';

class PokemonFavoritesPage extends StatefulWidget {
  const PokemonFavoritesPage({super.key});

  @override
  State<PokemonFavoritesPage> createState() => _PokemonFavoritesPageState();
}

class _PokemonFavoritesPageState extends State<PokemonFavoritesPage>
    with AutomaticKeepAliveClientMixin {
  late PokemonCubit _pokemonCubit;

  @override
  void initState() {
    super.initState();
    _pokemonCubit = context.read<PokemonCubit>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PokemonCubit, PokemonState>(
      bloc: _pokemonCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
          ),
          body: state.cache.pokemons.isEmpty
              ? const Center(
                  child: EmptyMessage(
                    message: 'No favorites yet, add some!',
                  ),
                )
              : PokemonList(
                  pokemons: state.cache.pokemons,
                ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
