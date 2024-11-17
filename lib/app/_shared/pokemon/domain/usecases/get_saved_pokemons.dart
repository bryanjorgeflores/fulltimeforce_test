import 'package:fpdart/fpdart.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/core/error_handler/error_handler.dart';
import 'package:fulltimeforce_test/core/sqlite/sqlite.dart';

class GetSavedPokemons {
  Future<Either<Failure, List<Pokemon>>> call() async {
    try {
      final pokemon = await SQLiteHelper().getPokemons();
      return Right(pokemon);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, int?>> savePokemon(Pokemon pokemon) async {
    try {
      final value = await SQLiteHelper().insertPokemon(pokemon);
      return Right(value);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, int?>> deletePokemon(Pokemon pokemon) async {
    try {
      final value = await SQLiteHelper().deletePokemon(pokemon);
      return Right(value);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
