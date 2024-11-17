import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  final List<PokemonAbility>? abilities;
  final int? baseExperience;
  final List<PokemonSpecies>? forms;
  final int? height;
  final int? id;
  final List<PokemonMove>? moves;
  final String? name;
  final int? order;
  final PokemonSpecies? species;
  final PokemonSprites? sprites;
  final List<PokemonStat>? stats;
  final List<PokemonType>? types;
  final int? weight;
  final bool? favorite;
  final PokemonCries? cries;

  Pokemon({
    this.abilities,
    this.baseExperience,
    this.forms,
    this.height,
    this.id,
    this.moves,
    this.name,
    this.order,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
    this.favorite,
    this.cries,
  });

  Pokemon copyWith({
    List<PokemonAbility>? abilities,
    int? baseExperience,
    List<PokemonSpecies>? forms,
    int? height,
    int? id,
    List<PokemonMove>? moves,
    String? name,
    int? order,
    PokemonSpecies? species,
    PokemonSprites? sprites,
    List<PokemonStat>? stats,
    List<PokemonType>? types,
    int? weight,
    bool? favorite,
    PokemonCries? cries,
  }) =>
      Pokemon(
        abilities: abilities ?? this.abilities,
        baseExperience: baseExperience ?? this.baseExperience,
        forms: forms ?? this.forms,
        height: height ?? this.height,
        id: id ?? this.id,
        moves: moves ?? this.moves,
        name: name ?? this.name,
        order: order ?? this.order,
        species: species ?? this.species,
        sprites: sprites ?? this.sprites,
        stats: stats ?? this.stats,
        types: types ?? this.types,
        weight: weight ?? this.weight,
        favorite: favorite ?? this.favorite,
        cries: cries ?? this.cries,
      );

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        abilities: json["abilities"] == null
            ? []
            : List<PokemonAbility>.from(
                json["abilities"]!.map((x) => PokemonAbility.fromJson(x))),
        baseExperience: json["base_experience"],
        forms: json["forms"] == null
            ? []
            : List<PokemonSpecies>.from(
                json["forms"]!.map((x) => PokemonSpecies.fromJson(x))),
        height: json["height"],
        id: json["id"],
        moves: json["moves"] == null
            ? []
            : List<PokemonMove>.from(
                json["moves"]!.map((x) => PokemonMove.fromJson(x))),
        name: json["name"],
        order: json["order"],
        species: json["species"] == null
            ? null
            : PokemonSpecies.fromJson(json["species"]),
        sprites: json["sprites"] == null
            ? null
            : PokemonSprites.fromJson(json["sprites"]),
        stats: json["stats"] == null
            ? []
            : List<PokemonStat>.from(
                json["stats"]!.map((x) => PokemonStat.fromJson(x))),
        types: json["types"] == null
            ? []
            : List<PokemonType>.from(
                json["types"]!.map((x) => PokemonType.fromJson(x))),
        weight: json["weight"],
        favorite: json["favorite"],
        cries:
            json["cries"] == null ? null : PokemonCries.fromJson(json["cries"]),
      );

  Map<String, dynamic> toJson() => {
        "abilities": abilities == null
            ? []
            : List<dynamic>.from(abilities!.map((x) => x.toJson())),
        "base_experience": baseExperience,
        "forms": forms == null
            ? []
            : List<dynamic>.from(forms!.map((x) => x.toJson())),
        "height": height,
        "id": id,
        "moves": moves == null
            ? []
            : List<dynamic>.from(moves!.map((x) => x.toJson())),
        "name": name,
        "order": order,
        "species": species?.toJson(),
        "sprites": sprites?.toJson(),
        "stats": stats == null
            ? []
            : List<dynamic>.from(stats!.map((x) => x.toJson())),
        "types": types == null
            ? []
            : List<dynamic>.from(types!.map((x) => x.toJson())),
        "weight": weight,
        "favorite": favorite,
        "cries": cries?.toJson(),
      };
}

class PokemonAbility {
  final PokemonSpecies? ability;
  final bool? isHidden;
  final int? slot;

  PokemonAbility({
    this.ability,
    this.isHidden,
    this.slot,
  });

  PokemonAbility copyWith({
    PokemonSpecies? ability,
    bool? isHidden,
    int? slot,
  }) =>
      PokemonAbility(
        ability: ability ?? this.ability,
        isHidden: isHidden ?? this.isHidden,
        slot: slot ?? this.slot,
      );

  factory PokemonAbility.fromJson(Map<String, dynamic> json) => PokemonAbility(
        ability: json["ability"] == null
            ? null
            : PokemonSpecies.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability?.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class PokemonSpecies {
  final String? name;
  final String? url;

  PokemonSpecies({
    this.name,
    this.url,
  });

  PokemonSpecies copyWith({
    String? name,
    String? url,
  }) =>
      PokemonSpecies(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) => PokemonSpecies(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class PokemonMove {
  final PokemonSpecies? move;

  PokemonMove({
    this.move,
  });

  PokemonMove copyWith({
    PokemonSpecies? move,
  }) =>
      PokemonMove(
        move: move ?? this.move,
      );

  factory PokemonMove.fromJson(Map<String, dynamic> json) => PokemonMove(
        move:
            json["move"] == null ? null : PokemonSpecies.fromJson(json["move"]),
      );

  Map<String, dynamic> toJson() => {
        "move": move?.toJson(),
      };
}

class PokemonSprites {
  PokemonSprites(
      {this.backDefault,
      this.backFemale,
      this.backShiny,
      this.backShinyFemale,
      this.frontDefault,
      this.frontFemale,
      this.frontShiny,
      this.frontShinyFemale,
      this.officialArtwork});

  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;
  String? officialArtwork;

  factory PokemonSprites.fromJson(Map<String, dynamic> json) => PokemonSprites(
        backDefault: json["back_default"] as String?,
        backFemale: json["back_female"] as String?,
        backShiny: json["back_shiny"] as String?,
        backShinyFemale: json["back_shiny_female"] as String?,
        frontDefault: json["front_default"] ??
            json["other"]?["home"]?["front_default"] as String? ??
            '',
        frontFemale: json["front_female"] ??
            json["other"]?["home"]?["front_female"] as String? ??
            '',
        frontShiny: json["front_shiny"] ??
            json["other"]?["home"]?["front_shiny"] as String? ??
            '',
        frontShinyFemale: json["front_shiny_female"] ??
            json["other"]?["home"]?["front_shiny_female"] as String? ??
            '',
        officialArtwork: json["official-artwork"] ??
            json["other"]?["official-artwork"]?["front_default"] as String? ??
            '',
      );
  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
        "official-artwork": officialArtwork
      };
}

class PokemonStat {
  final int? baseStat;
  final int? effort;
  final PokemonSpecies? stat;

  PokemonStat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  PokemonStat copyWith({
    int? baseStat,
    int? effort,
    PokemonSpecies? stat,
  }) =>
      PokemonStat(
        baseStat: baseStat ?? this.baseStat,
        effort: effort ?? this.effort,
        stat: stat ?? this.stat,
      );

  factory PokemonStat.fromJson(Map<String, dynamic> json) => PokemonStat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat:
            json["stat"] == null ? null : PokemonSpecies.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat?.toJson(),
      };
}

class PokemonType {
  final int? slot;
  final PokemonSpecies? type;

  PokemonType({
    this.slot,
    this.type,
  });

  PokemonType copyWith({
    int? slot,
    PokemonSpecies? type,
  }) =>
      PokemonType(
        slot: slot ?? this.slot,
        type: type ?? this.type,
      );

  factory PokemonType.fromJson(Map<String, dynamic> json) => PokemonType(
        slot: json["slot"],
        type:
            json["type"] == null ? null : PokemonSpecies.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type?.toJson(),
      };
}

class PokemonCries {
  final String? latest;
  final String? legacy;

  PokemonCries({
    this.latest,
    this.legacy,
  });

  PokemonCries copyWith({
    String? latest,
    String? legacy,
  }) =>
      PokemonCries(
        latest: latest ?? this.latest,
        legacy: legacy ?? this.legacy,
      );

  factory PokemonCries.fromJson(Map<String, dynamic> json) => PokemonCries(
        latest: json["latest"],
        legacy: json["legacy"],
      );

  Map<String, dynamic> toJson() => {
        "latest": latest,
        "legacy": legacy,
      };
}
