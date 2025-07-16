import 'package:rest_countries/src/data/countries_api.dart';
import 'package:rest_countries/src/domain/country_model.dart';
import 'package:rest_countries/src/domain/enums/country_fields.dart';
import 'package:rest_countries/src/repository/countries_repository.dart';

class CountriesRepositoryImpl implements CountryRepository {
  final CountriesApi countriesApi;
  CountriesRepositoryImpl(this.countriesApi);

  @override
  Future<List<CountryModel>> getAllCountries({
    required List<CountryFields> fields,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getAllCountries(fields: fields);

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<List<CountryModel>> getCountriesByCapital({
    required String capital,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountriesByCapital(capital: capital);

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<CountryModel> getCountryByCode({required String code}) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryByCode(code: code);

    return CountryModel.fromJson(response.first);
  }

  @override
  Future<List<CountryModel>> getCountriesByCodes({
    required List<String> codes,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryByCodes(codes: codes);

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<List<CountryModel>> getCountriesByCurrency({
    required String currency,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryByCurrency(currency: currency);

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<List<CountryModel>> getCountriesByDemonym({
    required String demonym,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryByDemonym(demonym: demonym);

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<List<CountryModel>> getCountriesByLanguage({
    required String language,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryByLanguage(language: language);

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<List<CountryModel>> getCountriesByRegion({
    required String region,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryByRegion(region: region);

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<List<CountryModel>> getCountriesBySubRegion({
    required String subRegion,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryBySubRegion(
      subRegion: subRegion,
    );

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<List<CountryModel>> getCountriesByTranslation({
    required String translation,
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryByTranslation(
      translation: translation,
    );

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<CountryModel> getCountryByFullName({required String fullName}) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountryByFullName(fullName: fullName);

    return CountryModel.fromJson(response.first);
  }

  @override
  Future<List<CountryModel>> getCountriesByName({required String name}) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountriesByName(name: name);

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }

  @override
  Future<List<CountryModel>> getCountriesByIndependentStatus({
    bool independent = true,
    List<CountryFields> fields = const <CountryFields>[],
  }) async {
    List<Map<String, dynamic>> response = await countriesApi.getCountriesByIndependentStatus(
      independent: independent,
      fields: fields,
    );

    List<CountryModel> countryModelList =
        response.map((Map<String, dynamic> country) => CountryModel.fromJson(country)).toList();

    return countryModelList;
  }
}
