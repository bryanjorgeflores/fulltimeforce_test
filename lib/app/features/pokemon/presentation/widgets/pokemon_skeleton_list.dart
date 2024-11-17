import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/enums/pokemon_colors_enum.dart';
import 'package:shimmer/shimmer.dart';

class PokemonLoadingSkeleton extends StatelessWidget {
  const PokemonLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Positioned(
              right: -45,
              top: -45,
              child: Image.asset(
                'assets/images/logo.png',
                height: 240,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            Ink(
              height: 120,
              decoration: BoxDecoration(
                color: PokemonColors.values
                    .elementAt(Random().nextInt(PokemonColors.values.length))
                    .color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 30,
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 100,
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 18,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (double kind in [0, 1])
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: (80 + kind),
                        height: 10,
                        margin: const EdgeInsets.only(right: 8),
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
