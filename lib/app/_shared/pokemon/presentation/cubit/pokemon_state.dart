part of 'pokemon_cubit.dart';

abstract class PokemonState extends Equatable {
  const PokemonState(this.cache);
  final PokemonStateCache cache;

  @override
  List<Object> get props => [cache];
}

class PokemonInitial extends PokemonState {
  const PokemonInitial(super.cache);
}

class PokemonLoading extends PokemonState {
  const PokemonLoading(super.cache);
}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;

  const PokemonLoaded(super.cache, {required this.pokemons});
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(super.cache, {required this.message});
}

class PokemonSavedLoaded extends PokemonState {
  final List<Pokemon> pokemons;

  const PokemonSavedLoaded(super.cache, {required this.pokemons});
}

class PokemonSaving extends PokemonState {
  const PokemonSaving(super.cache);
}

class PokemonSaved extends PokemonState {
  const PokemonSaved(super.cache);
}

class PokemonDeleting extends PokemonState {
  const PokemonDeleting(super.cache);
}

class PokemonDeleted extends PokemonState {
  const PokemonDeleted(super.cache);
}

class PokemonSaveError extends PokemonState {
  final String message;

  const PokemonSaveError(super.cache, {required this.message});
}

class PokemonDeleteError extends PokemonState {
  final String message;

  const PokemonDeleteError(super.cache, {required this.message});
}

class PokemonSearching extends PokemonState {
  const PokemonSearching(super.cache);
}

class PokemonFounded extends PokemonState {
  const PokemonFounded(super.cache);
}

class PokemonSearchError extends PokemonState {
  final String message;
  const PokemonSearchError(super.cache, {required this.message});
}

class PokemonStateCache extends Equatable {
  final List<Pokemon> pokemons;
  final List<Pokemon> foundPokemons;

  const PokemonStateCache({
    this.pokemons = const [],
    this.foundPokemons = const [],
  });

  const PokemonStateCache.initial()
      : pokemons = const [],
        foundPokemons = const [];

  @override
  List<Object> get props => [pokemons, foundPokemons];

  PokemonStateCache copyWith({
    List<Pokemon>? pokemons,
    List<Pokemon>? foundedPokemons,
  }) {
    return PokemonStateCache(
      pokemons: pokemons ?? this.pokemons,
      foundPokemons: foundedPokemons ?? foundPokemons,
    );
  }
}
