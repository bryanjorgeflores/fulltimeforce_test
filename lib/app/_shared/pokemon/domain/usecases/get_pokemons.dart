import 'package:fpdart/fpdart.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/core/error_handler/error_handler.dart';

class GetPokemons {
  GetPokemons(this._pokemonRepository);

  final PokemonRepository _pokemonRepository;

  Future<Either<Failure, List<Pokemon>>> call({
    required int page,
    bool forceRefresh = false,
  }) async {
    try {
      final pokemons = await _pokemonRepository.getPokemons(
        page: page,
        forceRefresh: forceRefresh,
      );

      final futures = pokemons
          .map((pokemon) =>
              getPokemonDetail(url: pokemon.url!, forceRefresh: forceRefresh))
          .toList();

      final pokemonsWithDetailFutures = await Future.wait(futures);

      final pokemonsWithDetail = pokemonsWithDetailFutures
          .map((e) => e.fold((l) => null, (r) => r))
          .whereType<Pokemon>()
          .toList();

      return Right(pokemonsWithDetail);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, Pokemon>> getPokemonDetail({
    required String url,
    bool forceRefresh = false,
  }) async {
    try {
      final pokemon = await _pokemonRepository.getPokemonDetail(
        url: url,
        forceRefresh: forceRefresh,
      );
      return Right(pokemon);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
