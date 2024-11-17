import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/widgets/pokemon_tile.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/features/pokemon/presentation/widgets/pokemon_skeleton_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PokemonInfiniteList extends StatefulWidget {
  final PagingController<int, Pokemon> pagingController;
  const PokemonInfiniteList({super.key, required this.pagingController});

  @override
  State<PokemonInfiniteList> createState() => _PokemonInfiniteListState();
}

class _PokemonInfiniteListState extends State<PokemonInfiniteList> {
  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Pokemon>.separated(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      pagingController: widget.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (BuildContext context, Pokemon pokemon, int index) {
          return PokemonTile(pokemon: pokemon);
        },
        firstPageProgressIndicatorBuilder: (context) {
          return const PokemonLoadingSkeleton();
        },
        newPageProgressIndicatorBuilder: (context) {
          return const PokemonLoadingSkeleton();
        },
      ),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}
