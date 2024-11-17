import 'package:fulltimeforce_test/app/_shared/pokemon/data/datasources/pokemon_datasource.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/usecases/get_pokemons.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/usecases/get_saved_pokemons.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/usecases/search_pokemon.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/presentation/cubit/pokemon_cubit.dart';
import 'package:fulltimeforce_test/core/dio.dart';
import 'package:get_it/get_it.dart';

import '../_shared/pokemon/data/datasources/remote/pokemon_api_client.dart';

class DependencyInjection {
  static final GetIt getIt = GetIt.instance;

  static Future<GetIt> init() async {
    final di = await _initGetIt(getIt);
    return di;
  }

  static _initGetIt(GetIt getIt) async {
    final dioHelper = DioHelper();
    await dioHelper.init();
    getIt.registerSingleton<DioHelper>(dioHelper);
    getIt.registerSingleton<PokemonDatasource>(
      PokemonApiClient(getIt<DioHelper>()),
    );
    getIt.registerSingleton<PokemonRepository>(
      PokemonRepositoryImpl(getIt<PokemonDatasource>()),
    );
    getIt.registerSingleton<GetPokemons>(
      GetPokemons(getIt<PokemonRepository>()),
    );
    getIt.registerSingleton<GetSavedPokemons>(
      GetSavedPokemons(),
    );
    getIt.registerSingleton<SearchPokemon>(
      SearchPokemon(getIt<PokemonRepository>()),
    );

    getIt.registerSingleton<PokemonCubit>(
      PokemonCubit(
        getIt<GetPokemons>(),
        getIt<GetSavedPokemons>(),
        getIt<SearchPokemon>(),
      ),
    );

    return getIt;
  }
}
