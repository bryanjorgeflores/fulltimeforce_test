import 'package:fulltimeforce_test/app/_shared/pokemon/data/models/specie.dart';

class PokemonType {
  PokemonType({
    this.slot,
    this.type,
  });

  int? slot;
  PokemonSpecies? type;

  factory PokemonType.fromJson(Map<String, dynamic> json) => PokemonType(
        slot: json["slot"],
        type: PokemonSpecies.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type?.toJson(),
      };
}
