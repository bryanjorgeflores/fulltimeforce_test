import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';

abstract class PokemonDatasource {
  Future<List<PokemonSpecies>> getPokemons({
    required int page,
    bool forceRefresh = false,
  });

  Future<Pokemon> getPokemonDetail({
    required String url,
    bool forceRefresh = false,
  });

  Future<Pokemon> searchPokemon({
    required String nameOrCode,
  });
}
