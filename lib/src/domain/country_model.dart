//ignore_for_file: always_specify_types
class CountryModel {
  final Name? name;
  final String? cca2;
  final String? cca3;
  final String? ccn3;
  final String? cioc;
  final bool? independent;
  final String? status;
  final String? flag;
  final bool? unMember;
  final List<String>? capital;
  final String? region;
  final String? subregion;
  final List<String>? continents;
  final int? population;
  final double? area;
  final Map<String, double>? gini;
  final List<String>? timezones;
  final List<String>? topLevelDomain;
  final List<double>? latlng;
  final String? demonym;
  final List<String>? borders;
  final Map<String, Currency>? currencies;
  final Idd? idd;
  final Map<String, String>? languages;
  final Map<String, Translation>? translations;
  final Flags? flags;
  final List<RegionalBloc>? regionalBlocs;
  final List<String>? altSpellings;
  final CapitalInfo? capitalInfo;
  final Car? car;
  final CoatOfArms? coatOfArms;
  final Map<String, GenderedDemonym>? demonyms;
  final String? fifa;
  final Maps? maps;
  final String? startOfWeek;
  final bool? landlocked;

  CountryModel({
    this.name,
    this.cca2,
    this.cca3,
    this.flag,
    this.ccn3,
    this.landlocked,
    this.maps,
    this.cioc,
    this.car,
    this.independent,
    this.status,
    this.unMember,
    this.capital,
    this.region,
    this.subregion,
    this.continents,
    this.fifa,
    this.population,
    this.area,
    this.gini,
    this.timezones,
    this.topLevelDomain,
    this.latlng,
    this.demonym,
    this.borders,
    this.currencies,
    this.idd,
    this.languages,
    this.translations,
    this.flags,
    this.regionalBlocs,
    this.demonyms,
    this.altSpellings,
    this.capitalInfo,
    this.startOfWeek,
    this.coatOfArms,
  });

  String get getCountryPhoneNumberCode =>
      '${idd?.root}${idd?.suffixes?.join()}';

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      cca2: json['cca2'],
      cca3: json['cca3'],
      ccn3: json['ccn3'],
      cioc: json['cioc'],
      fifa: json['fifa'],
      landlocked: json['landlocked'],
      independent: json['independent'],
      status: json['status'],
      unMember: json['unMember'],
      capital:
          (json['capital'] as List<dynamic>?)?.map((e) => e as String).toList(),
      region: json['region'],
      subregion: json['subregion'],
      continents: (json['continents'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      population: json['population'],
      area: (json['area'] is num) ? (json['area'] as num).toDouble() : null,
      gini: (json['gini'] as Map<String, dynamic>?)?.map(
        (String k, v) => MapEntry(k, (v as num).toDouble()),
      ),
      timezones: (json['timezones'] as List<dynamic>?)?.cast<String>(),
      topLevelDomain: (json['tld'] as List<dynamic>?)?.cast<String>(),
      latlng: (json['latlng'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      demonym: json['demonym'],
      borders: (json['borders'] as List<dynamic>?)?.cast<String>(),
      currencies: (json['currencies'] as Map<String, dynamic>?)?.map(
        (String k, v) => MapEntry(k, Currency.fromJson(v)),
      ),
      idd: json['idd'] != null ? Idd.fromJson(json['idd']) : null,
      languages: (json['languages'] as Map<String, dynamic>?)?.map(
        (String k, v) => MapEntry(k, v as String),
      ),
      translations: (json['translations'] as Map<String, dynamic>?)?.map(
        (String k, dynamic v) => MapEntry(k, Translation.fromJson(v)),
      ),
      flags: json['flags'] != null ? Flags.fromJson(json['flags']) : null,
      regionalBlocs: (json['regionalBlocs'] as List<dynamic>?)
          ?.map((e) => RegionalBloc.fromJson(e))
          .toList(),
      altSpellings: (json['altSpellings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      capitalInfo: json['capitalInfo'] != null
          ? CapitalInfo.fromJson(json['capitalInfo'])
          : null,
      car: json['car'] != null ? Car.fromJson(json['car']) : null,
      coatOfArms: json['coatOfArms'] != null
          ? CoatOfArms.fromJson(json['coatOfArms'])
          : null,
      maps: json['maps'] != null ? Maps.fromJson(json['maps']) : null,
      flag: json['flag'],
      startOfWeek: json['startOfWeek'],
      demonyms: (json['demonyms'] as Map<String, dynamic>?)?.map(
        (String key, value) => MapEntry(key, GenderedDemonym.fromJson(value)),
      ),
    );
  }

  @override
  String toString() {
    return 'CountryModel(\n'
        '  name: $name,\n'
        '  cca2: $cca2,\n'
        '  cca3: $cca3,\n'
        '  ccn3: $ccn3,\n'
        '  cioc: $cioc,\n'
        '  independent: $independent,\n'
        '  status: $status,\n'
        '  flag: $flag,\n'
        '  unMember: $unMember,\n'
        '  capital: $capital,\n'
        '  region: $region,\n'
        '  subregion: $subregion,\n'
        '  continents: $continents,\n'
        '  population: $population,\n'
        '  area: $area,\n'
        '  gini: $gini,\n'
        '  timezones: $timezones,\n'
        '  topLevelDomain: $topLevelDomain,\n'
        '  latlng: $latlng,\n'
        '  demonym: $demonym,\n'
        '  borders: $borders,\n'
        '  currencies: $currencies,\n'
        '  idd: $idd,\n'
        '  languages: $languages,\n'
        '  translations: $translations,\n'
        '  flags: $flags,\n'
        '  regionalBlocs: $regionalBlocs,\n'
        '  altSpellings: $altSpellings,\n'
        '  capitalInfo: $capitalInfo,\n'
        '  car: $car,\n'
        '  coatOfArms: $coatOfArms,\n'
        '  demonyms: $demonyms,\n'
        '  fifa: $fifa,\n'
        '  maps: $maps,\n'
        '  startOfWeek: $startOfWeek,\n'
        '  landlocked: $landlocked\n'
        ')';
  }
}

class Name {
  final String? common;
  final String? official;
  final Map<String, Translation>? nativeName;

  Name({this.common, this.official, this.nativeName});

  factory Name.fromJson(Map<String, dynamic> json) {
    final Map<String, Translation>? native =
        (json['nativeName'] as Map<String, dynamic>?)?.map(
      (String k, v) => MapEntry(k, Translation.fromJson(v)),
    );
    return Name(
      common: json['common'],
      official: json['official'],
      nativeName: native,
    );
  }

  @override
  String toString() {
    return 'Name(\n'
        '  common: $common,\n'
        '  official: $official,\n'
        '  nativeName: $nativeName\n'
        ')';
  }
}

class Currency {
  final String? name;
  final String? symbol;

  Currency({this.name, this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      Currency(name: json['name'], symbol: json['symbol']);

  @override
  String toString() {
    return 'Currency(\n'
        '  name: $name,\n'
        '  symbol: $symbol\n'
        ')';
  }
}

class Idd {
  final String? root;
  final List<String>? suffixes;

  Idd({this.root, this.suffixes});

  factory Idd.fromJson(Map<String, dynamic> json) => Idd(
        root: json['root'],
        suffixes: (json['suffixes'] as List<dynamic>?)?.cast<String>(),
      );

  @override
  String toString() {
    return 'Idd(\n'
        '  root: $root,\n'
        '  suffixes: $suffixes\n'
        ')';
  }
}

class Translation {
  final String? official;
  final String? common;

  Translation({this.official, this.common});

  factory Translation.fromJson(Map<String, dynamic> json) =>
      Translation(official: json['official'], common: json['common']);

  @override
  String toString() {
    return 'Translation(\n'
        '  official: $official,\n'
        '  common: $common\n'
        ')';
  }
}

class Flags {
  final String? svg;
  final String? png;

  Flags({this.svg, this.png});

  factory Flags.fromJson(Map<String, dynamic> json) =>
      Flags(svg: json['svg'], png: json['png']);

  @override
  String toString() {
    return 'Flags(\n'
        '  svg: $svg,\n'
        '  png: $png\n'
        ')';
  }
}

class RegionalBloc {
  final String? acronym;
  final String? name;
  final List<String>? otherAcronyms;
  final List<String>? otherNames;

  RegionalBloc({this.acronym, this.name, this.otherAcronyms, this.otherNames});

  factory RegionalBloc.fromJson(Map<String, dynamic> json) => RegionalBloc(
        acronym: json['acronym'],
        name: json['name'],
        otherAcronyms:
            (json['otherAcronyms'] as List<dynamic>?)?.cast<String>(),
        otherNames: (json['otherNames'] as List<dynamic>?)?.cast<String>(),
      );

  @override
  String toString() {
    return 'RegionalBloc(\n'
        '  acronym: $acronym,\n'
        '  name: $name,\n'
        '  otherAcronyms: $otherAcronyms,\n'
        '  otherNames: $otherNames\n'
        ')';
  }
}

class CapitalInfo {
  final List<double>? latlng;

  CapitalInfo({this.latlng});

  factory CapitalInfo.fromJson(Map<String, dynamic> json) {
    return CapitalInfo(
      latlng: (json['latlng'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  @override
  String toString() {
    return 'CapitalInfo(\n'
        '  latlng: $latlng\n'
        ')';
  }
}

class Car {
  final List<String>? signs;
  final String? side;

  Car({this.signs, this.side});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      signs:
          (json['signs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      side: json['side'],
    );
  }

  @override
  String toString() {
    return 'Car(\n'
        '  signs: $signs,\n'
        '  side: $side\n'
        ')';
  }
}

class CoatOfArms {
  final String? png;
  final String? svg;

  CoatOfArms({this.png, this.svg});

  factory CoatOfArms.fromJson(Map<String, dynamic> json) {
    return CoatOfArms(png: json['png'], svg: json['svg']);
  }
  @override
  String toString() {
    return 'CoatOfArms(\n'
        '  png: $png,\n'
        '  svg: $svg\n'
        ')';
  }
}

class GenderedDemonym {
  final String? f;
  final String? m;

  GenderedDemonym({this.f, this.m});

  factory GenderedDemonym.fromJson(Map<String, dynamic> json) {
    return GenderedDemonym(f: json['f'], m: json['m']);
  }
  @override
  String toString() {
    return 'GenderedDemonym(\n'
        '  f: $f,\n'
        '  m: $m\n'
        ')';
  }
}

class Maps {
  final String? googleMaps;
  final String? openStreetMaps;

  Maps({this.googleMaps, this.openStreetMaps});

  factory Maps.fromJson(Map<String, dynamic> json) {
    return Maps(
      googleMaps: json['googleMaps'],
      openStreetMaps: json['openStreetMaps'],
    );
  }

  @override
  String toString() {
    return 'Maps(\n'
        '  googleMaps: $googleMaps,\n'
        '  openStreetMaps: $openStreetMaps\n'
        ')';
  }
}
