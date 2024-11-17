import 'package:fpdart/fpdart.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/core/error_handler/error_handler.dart';

class SearchPokemon {
  SearchPokemon(this._pokemonRepository);

  final PokemonRepository _pokemonRepository;

  Future<Either<Failure, Pokemon>> call({
    required String nameOrCode,
  }) async {
    try {
      final pokemon = await _pokemonRepository.searchPokemon(
        nameOrCode: nameOrCode,
      );
      return Right(pokemon);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
