import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/features/pokemon/presentation/pages/pokemon_page.dart';
import 'package:fulltimeforce_test/app/features/pokemon_favorites/presentation/pages/pokemon_favorites_page.dart';
import 'package:fulltimeforce_test/app/features/pokemon_search/presentation/pages/pokemon_search.dart';

class HomeTabsPage extends StatefulWidget {
  const HomeTabsPage({super.key});

  @override
  State<HomeTabsPage> createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final pages = [
    const PokemonPage(),
    const PokemonSearchPage(),
    const PokemonFavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
