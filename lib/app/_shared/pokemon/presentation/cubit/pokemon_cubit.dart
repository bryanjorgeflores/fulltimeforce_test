import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/usecases/get_pokemons.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/usecases/get_saved_pokemons.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/usecases/search_pokemon.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final GetPokemons _getPokemons;
  final GetSavedPokemons _getSavedPokemons;
  final SearchPokemon _searchPokemon;
  PokemonCubit(
    this._getPokemons,
    this._getSavedPokemons,
    this._searchPokemon,
  ) : super(const PokemonInitial(PokemonStateCache.initial()));

  void getPokemons({
    int page = 0,
    bool forceRefresh = false,
  }) async {
    emit(PokemonLoading(
      state.cache,
    ));
    final pokemons = await _getPokemons(
      page: page,
      forceRefresh: forceRefresh,
    );

    pokemons.fold(
      (failure) => emit(PokemonError(state.cache, message: failure.message)),
      (pokemons) => emit(PokemonLoaded(state.cache, pokemons: pokemons)),
    );
  }

  void getSavedPokemons() async {
    emit(PokemonLoading(
      state.cache,
    ));
    final pokemons = await _getSavedPokemons();

    pokemons.fold(
      (failure) => emit(PokemonError(state.cache, message: failure.message)),
      (pokemons) => emit(PokemonSavedLoaded(
        state.cache.copyWith(pokemons: pokemons),
        pokemons: pokemons,
      )),
    );
  }

  void savePokemon(Pokemon pokemon) async {
    emit(PokemonSaving(state.cache));
    final result = await _getSavedPokemons.savePokemon(pokemon);

    result.fold(
      (failure) => emit(
        PokemonSaveError(
          state.cache,
          message: failure.message,
        ),
      ),
      (_) => emit(
        PokemonSaved(
          state.cache.copyWith(pokemons: state.cache.pokemons..add(pokemon)),
        ),
      ),
    );
  }

  void deletePokemon(Pokemon pokemon) async {
    emit(PokemonDeleting(state.cache));
    final result = await _getSavedPokemons.deletePokemon(pokemon);

    result.fold(
      (failure) => emit(
        PokemonDeleteError(
          state.cache,
          message: failure.message,
        ),
      ),
      (_) => emit(
        PokemonDeleted(
          state.cache.copyWith(
            pokemons: state.cache.pokemons
              ..removeWhere((p) => p.id == pokemon.id),
          ),
        ),
      ),
    );
  }

  void searchPokemon(String query) async {
    emit(PokemonSearching(state.cache));
    final filteredPokemons = await _searchPokemon(
      nameOrCode: query.toLowerCase(),
    );
    filteredPokemons.fold(
      (failure) => emit(
        PokemonSearchError(
          state.cache.copyWith(
            foundedPokemons: const [],
          ),
          message: failure.message,
        ),
      ),
      (pokemon) {
        emit(
          PokemonFounded(
            state.cache.copyWith(foundedPokemons: [pokemon]),
          ),
        );
      },
    );
  }
}
