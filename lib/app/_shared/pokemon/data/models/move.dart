import 'package:fulltimeforce_test/app/_shared/pokemon/data/models/specie.dart';

class PokemonMove {
  PokemonMove({
    this.move,
  });

  PokemonSpecies? move;

  factory PokemonMove.fromJson(Map<String, dynamic> json) => PokemonMove(
        move: PokemonSpecies.fromJson(json["move"]),
      );

  Map<String, dynamic> toJson() => {
        "move": move?.toJson(),
      };
}
