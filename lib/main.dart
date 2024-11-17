import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/presentation/cubit/pokemon_cubit.dart';
import 'package:fulltimeforce_test/app/dependency_injection/dependency_injection.dart';
import 'package:fulltimeforce_test/app/router/router.dart';
import 'package:get_it/get_it.dart';

late GetIt getIt;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt = await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonCubit>(
      create: (context) => getIt<PokemonCubit>(),
      child: const MaterialApp(
        title: 'FTF Test App',
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
