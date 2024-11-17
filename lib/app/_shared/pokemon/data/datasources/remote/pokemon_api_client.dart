import 'package:fulltimeforce_test/app/_shared/pokemon/data/datasources/pokemon_datasource.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/core/dio.dart';

class PokemonApiClient implements PokemonDatasource {
  final DioHelper _dio;

  PokemonApiClient(this._dio);

  @override
  Future<List<PokemonSpecies>> getPokemons(
      {required int page, bool forceRefresh = false}) async {
    final response = await _dio.get(
      '/pokemon/?limit=10&offset=${10 * page}',
      forceRefresh: forceRefresh,
    );
    final pokemons = response.data['results'] as List;

    final List<PokemonSpecies> pokemonsList =
        pokemons.map((pokemon) => PokemonSpecies.fromJson(pokemon)).toList();
    return pokemonsList;
  }

  @override
  Future<Pokemon> getPokemonDetail(
      {required String url, bool forceRefresh = false}) async {
    final response = await _dio.get(
      url,
      forceRefresh: forceRefresh,
    );
    return Pokemon.fromJson(response.data);
  }

  @override
  Future<Pokemon> searchPokemon({required String nameOrCode}) async {
    final response = await _dio.get(
      '/pokemon/$nameOrCode',
    );
    return Pokemon.fromJson(response.data);
  }
}
