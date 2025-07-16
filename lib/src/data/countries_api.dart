import 'package:rest_countries/src/data/api_helper.dart';
import 'package:rest_countries/src/domain/enums/country_fields.dart';

class CountriesApi {
  final ApiHelper apiHelper = ApiHelper();
  static const String baseUrl = 'https://restcountries.com/v3.1';

  Future<List<Map<String, dynamic>>> getAllCountries({
    required List<CountryFields> fields,
  }) async {
    if (fields.length > 10) {
      throw Exception('Fields cannot be more than 10');
    }

    if (fields.isEmpty) {
      throw Exception('Fields cannot be empty');
    }
    final String apiQueryFields = buildCountryQueryFields(
      countryFields: fields,
    );

    return await apiHelper.callAPI(
      apiUrl: '$baseUrl/all?fields=$apiQueryFields',
    );
  }

  Future<List<Map<String, dynamic>>> getCountriesByCapital({
    required String capital,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/capital/$capital');
  }

  Future<List<Map<String, dynamic>>> getCountryByCode({
    required String code,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/alpha/$code');
  }

  Future<List<Map<String, dynamic>>> getCountryByCodes({
    required List<String> codes,
  }) async {
    String formattedCodes = codes.map((code) => code).toList().join(',');
    return await apiHelper.callAPI(
      apiUrl: '$baseUrl/alpha?codes=$formattedCodes',
    );
  }

  Future<List<Map<String, dynamic>>> getCountryByCurrency({
    required String currency,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/currency/$currency');
  }

  Future<List<Map<String, dynamic>>> getCountryByDemonym({
    required String demonym,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/demonym/$demonym');
  }

  Future<List<Map<String, dynamic>>> getCountryByLanguage({
    required String language,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/lang/$language');
  }

  Future<List<Map<String, dynamic>>> getCountryByRegion({
    required String region,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/region/$region');
  }

  Future<List<Map<String, dynamic>>> getCountryBySubRegion({
    required String subRegion,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/subregion/$subRegion');
  }

  Future<List<Map<String, dynamic>>> getCountryByTranslation({
    required String translation,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/translation/$translation');
  }

  Future<List<Map<String, dynamic>>> getCountryByFullName({
    required String fullName,
  }) async {
    return await apiHelper.callAPI(
      apiUrl: '$baseUrl/name/$fullName?fullText=true',
    );
  }

  Future<List<Map<String, dynamic>>> getCountriesByName({
    required String name,
  }) async {
    return await apiHelper.callAPI(apiUrl: '$baseUrl/name/$name');
  }

  Future<List<Map<String, dynamic>>> getCountriesByIndependentStatus({
    bool independent = true,
    List<CountryFields> fields = const [],
  }) async {
    final String apiQueryFields = buildCountryQueryFields(
      countryFields: fields,
    );

    return await apiHelper.callAPI(
      apiUrl: '$baseUrl/independent?status=$independent&fields=$apiQueryFields',
    );
  }
}
