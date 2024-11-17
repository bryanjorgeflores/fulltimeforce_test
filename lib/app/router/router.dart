import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/features/home_tabs/home_tabs_page.dart';
import 'package:fulltimeforce_test/app/features/pokemon_details/presentation/pages/pokemon_details_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeTabsPage(),
        );
      case '/pokemon-details':
        return MaterialPageRoute(
          builder: (_) => PokemonDetailsPage(
            pokemon: settings.arguments as Pokemon,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
