import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:lottie/lottie.dart';

class PokemonImageGallery extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonImageGallery({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokemonImageGallery> createState() => _PokemonImageGalleryState();
}

class _PokemonImageGalleryState extends State<PokemonImageGallery> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> _getImageUrls(Pokemon pokemon) {
    List<String?> urls = [];
    if (pokemon.sprites != null) {
      final sprites = pokemon.sprites!;
      urls.add(sprites.officialArtwork);
      urls.add(sprites.backDefault);
      urls.add(sprites.backFemale);
      urls.add(sprites.backShiny);
      urls.add(sprites.backShinyFemale);
      urls.add(sprites.frontDefault);
      urls.add(sprites.frontFemale);
      urls.add(sprites.frontShiny);
      urls.add(sprites.frontShinyFemale);
    }
    urls.removeWhere(
      (element) => (element?.isEmpty ?? false) || element == null,
    );
    return urls.map((e) => e!).toList();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrls = _getImageUrls(widget.pokemon);

    return imageUrls.isEmpty
        ? const Center(child: Text('No images available'))
        : Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              height: 10,
                              width: 140,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.35),
                                    blurRadius: 40,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 10,
                                    blurStyle: BlurStyle.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CachedNetworkImage(
                          height: 300,
                          imageUrl: imageUrls[index],
                          progressIndicatorBuilder: (context, url, progress) =>
                              Lottie.asset('assets/json/loading.json'),
                          errorWidget: (context, error, stackTrace) {
                            return Image.asset('assets/images/whosthat.png');
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imageUrls.length,
                    (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.black54
                              : Colors.black12,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
