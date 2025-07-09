enum CountryFields {
  name,
  cca2,
  cca3,
  ccn3,
  cioc,
  independent,
  status,
  flag,
  unMember,
  capital,
  region,
  subregion,
  continents,
  population,
  area,
  gini,
  timezones,
  topLevelDomain,
  latlng,
  demonym,
  borders,
  currencies,
  idd,
  languages,
  translations,
  flags,
  regionalBlocs,
  altSpellings,
  capitalInfo,
  car,
  coatOfArms,
  demonyms,
  fifa,
  maps,
  startOfWeek,
  landlocked,
}

extension CountryFieldsExtension on CountryFields {
  String get apiValue {
    switch (this) {
      case CountryFields.ccn3:
        return "ccn3";
      case CountryFields.cioc:
        return "cioc";
      case CountryFields.independent:
        return "independent";
      case CountryFields.status:
        return "status";
      case CountryFields.flag:
        return "flag";
      case CountryFields.unMember:
        return "unMember";
      case CountryFields.capital:
        return "capital";
      case CountryFields.region:
        return "region";
      case CountryFields.subregion:
        return "subregion";
      case CountryFields.continents:
        return "continents";
      case CountryFields.population:
        return "population";
      case CountryFields.area:
        return "area";
      case CountryFields.gini:
        return "gini";
      case CountryFields.timezones:
        return "timezones";
      case CountryFields.topLevelDomain:
        return "tld";
      case CountryFields.latlng:
        return "latlng";
      case CountryFields.demonym:
        return "demonym";
      case CountryFields.borders:
        return "borders";
      case CountryFields.currencies:
        return "currencies";
      case CountryFields.idd:
        return "idd";
      case CountryFields.languages:
        return "languages";
      case CountryFields.translations:
        return "translations";
      case CountryFields.flags:
        return "flags";
      case CountryFields.regionalBlocs:
        return "regionalBlocs";
      case CountryFields.altSpellings:
        return "altSpellings";
      case CountryFields.capitalInfo:
        return "capitalInfo";
      case CountryFields.car:
        return "car";
      case CountryFields.coatOfArms:
        return "coatOfArms";
      case CountryFields.demonyms:
        return "demonyms";
      case CountryFields.fifa:
        return "fifa";
      case CountryFields.maps:
        return "maps";
      case CountryFields.startOfWeek:
        return "startOfWeek";
      case CountryFields.landlocked:
        return "landlocked";
      case CountryFields.name:
        return "name";
      case CountryFields.cca2:
        return "cca2";
      case CountryFields.cca3:
        return "cca3";
    }
  }
}

String buildCountryQueryFields({required List<CountryFields> countryFields}) {
  return countryFields.map((field) => field.apiValue).toList().join(',');
}
