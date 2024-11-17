import 'package:fulltimeforce_test/app/_shared/pokemon/data/datasources/pokemon_datasource.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDatasource _pokemonDatasource;

  const PokemonRepositoryImpl(this._pokemonDatasource);

  @override
  Future<List<PokemonSpecies>> getPokemons({
    required int page,
    bool forceRefresh = false,
  }) async {
    return _pokemonDatasource.getPokemons(
      page: page,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<Pokemon> getPokemonDetail({
    required String url,
    bool forceRefresh = false,
  }) async {
    return _pokemonDatasource.getPokemonDetail(
      url: url,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<Pokemon> searchPokemon({
    required String nameOrCode,
  }) async {
    return _pokemonDatasource.searchPokemon(
      nameOrCode: nameOrCode,
    );
  }
}
