import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/presentation/cubit/pokemon_cubit.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/widgets/empty_message.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/widgets/pokemon_list.dart';

class PokemonSearchPage extends StatefulWidget {
  const PokemonSearchPage({super.key});

  @override
  State<PokemonSearchPage> createState() => _PokemonSearchPageState();
}

class _PokemonSearchPageState extends State<PokemonSearchPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();
  late PokemonCubit _pokemonCubit;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _pokemonCubit = context.read<PokemonCubit>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            autofocus: true,
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Ex: Pikachu or 25',
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) {
                _debounce?.cancel();
              }
              _debounce = Timer(const Duration(milliseconds: 500), () {
                _pokemonCubit.searchPokemon(value);
              });
            },
            onTapOutside: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
        body: BlocBuilder<PokemonCubit, PokemonState>(
          bloc: _pokemonCubit,
          builder: (context, state) {
            if (_controller.text.isEmpty) {
              return const Center(
                child: EmptyMessage(message: 'Search for a pokemon'),
              );
            }
            if (state.cache.foundPokemons.isNotEmpty &&
                state is! PokemonSearching) {
              final foundPokemons = state.cache.foundPokemons;
              return PokemonList(
                pokemons: foundPokemons,
              );
            }

            switch (state) {
              case PokemonSearching _:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PokemonFounded _:
                final foundPokemons = state.cache.foundPokemons;
                return PokemonList(
                  pokemons: foundPokemons,
                );
              case PokemonSearchError _:
                final message = state.message;
                return Center(
                  child: EmptyMessage(message: message),
                );
              default:
                return const Center(
                  child: EmptyMessage(message: 'No pokemon found'),
                );
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
