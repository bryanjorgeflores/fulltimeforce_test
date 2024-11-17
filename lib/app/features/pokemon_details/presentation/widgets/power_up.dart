import 'package:flutter/material.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/enums/pokemon_colors_enum.dart';

class PowerUpPokemon extends StatelessWidget {
  final Pokemon pokemon;
  const PowerUpPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 60,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.limeAccent[700],
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text(
                  'POWER UP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  'assets/images/stardust.png',
                  height: 20,
                ),
                const Text(
                  '4,500',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              Image.asset(
                'assets/images/candy.png',
                height: 20,
                color: PokemonColors.values
                    .firstWhere((element) =>
                        element.code == pokemon.types!.first.type!.name)
                    .color,
              ),
              const Text(
                '4',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }
}
