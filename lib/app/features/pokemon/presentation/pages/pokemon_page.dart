import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/presentation/cubit/pokemon_cubit.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/widgets/toast.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/features/pokemon/presentation/widgets/pokemon_infinite_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage>
    with AutomaticKeepAliveClientMixin {
  late PokemonCubit _pokemonCubit;
  final PagingController<int, Pokemon> _pagingController =
      PagingController(firstPageKey: 0);

  int page = 0;
  bool forceRefresh = false;

  @override
  void initState() {
    super.initState();
    _pokemonCubit = context.read<PokemonCubit>();
    _pokemonCubit.getSavedPokemons();
    _pagingController.addPageRequestListener((_) {
      _pokemonCubit.getPokemons(page: page, forceRefresh: forceRefresh);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  _blocListener(BuildContext context, PokemonState state) {
    if (state is PokemonLoaded) {
      bool isLastPage = state.pokemons.length < 10;
      if (!isLastPage) {
        _pagingController.appendPage(state.pokemons, page);
        setState(() {
          page++;
        });
      } else {
        _pagingController.appendLastPage(state.pokemons);
      }
      setState(() {});
    } else if (state is PokemonError) {
      _pagingController.error = state.message;
      Toast.show(context, state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<PokemonCubit, PokemonState>(
      bloc: _pokemonCubit,
      listener: _blocListener,
      child: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Pokedex'),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  page = 0;
                  forceRefresh = true;
                });
                _pagingController.refresh();
                await Future.delayed(const Duration(seconds: 1));
              },
              child: PokemonInfiniteList(
                pagingController: _pagingController,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
