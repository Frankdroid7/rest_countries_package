export 'src/domain/country_model.dart';
export 'src/domain/enums/country_fields.dart';

import 'package:rest_countries/src/data/countries_api.dart';
import 'package:rest_countries/src/domain/country_model.dart';
import 'package:rest_countries/src/domain/enums/country_fields.dart';
import 'package:rest_countries/src/repository/countries_repository_impl.dart';

class RestCountries {
  static final CountriesRepositoryImpl _repo =
      CountriesRepositoryImpl(CountriesApi());

  static Future<List<CountryModel>> getAllCountries({
    required List<CountryFields> fields,
  }) {
    return _repo.getAllCountries(fields: fields);
  }

  static Future<List<CountryModel>> getCountriesByCapital({
    required String capital,
  }) {
    return _repo.getCountriesByCapital(capital: capital);
  }

  static Future<CountryModel> getCountryByCode({
    required String code,
  }) {
    return _repo.getCountryByCode(code: code);
  }

  static Future<List<CountryModel>> getCountriesByCodes({
    required List<String> codes,
  }) {
    return _repo.getCountriesByCodes(codes: codes);
  }

  static Future<List<CountryModel>> getCountriesByCurrency({
    required String currency,
  }) {
    return _repo.getCountriesByCurrency(currency: currency);
  }

  static Future<List<CountryModel>> getCountriesByDemonym({
    required String demonym,
  }) {
    return _repo.getCountriesByDemonym(demonym: demonym);
  }

  static Future<List<CountryModel>> getCountriesByLanguage({
    required String language,
  }) {
    return _repo.getCountriesByLanguage(language: language);
  }

  static Future<List<CountryModel>> getCountriesByRegion({
    required String region,
  }) {
    return _repo.getCountriesByRegion(region: region);
  }

  static Future<List<CountryModel>> getCountriesBySubRegion({
    required String subRegion,
  }) {
    return _repo.getCountriesBySubRegion(subRegion: subRegion);
  }

  static Future<List<CountryModel>> getCountriesByTranslation({
    required String translation,
  }) {
    return _repo.getCountriesByTranslation(translation: translation);
  }

  static Future<CountryModel> getCountryByFullName({
    required String fullName,
  }) {
    return _repo.getCountryByFullName(fullName: fullName);
  }

  static Future<List<CountryModel>> getCountriesByName({
    required String name,
  }) {
    return _repo.getCountriesByName(name: name);
  }

  static Future<List<CountryModel>> getCountriesByIndependentStatus({
    bool independent = true,
    List<CountryFields> fields = const [],
  }) {
    return _repo.getCountriesByIndependentStatus(
      independent: independent,
      fields: fields,
    );
  }
}
