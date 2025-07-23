import 'package:rest_countries_data/src/data/api_helper.dart';
import 'package:rest_countries_data/src/domain/enums/country_fields.dart';

class CountriesApi {
  final ApiHelper apiHelper = ApiHelper();

  Future<List<Map<String, dynamic>>> getAllCountries({
    required List<CountryFields> fields,
  }) async {
    final String apiQueryFields = buildCountryQueryFields(
      countryFields: fields,
    );

    return await apiHelper.callAPI(
      apiUrl: '/all?fields=$apiQueryFields',
    );
  }

  Future<List<Map<String, dynamic>>> getCountriesByCapital({
    required String capital,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/capital/$capital');
  }

  Future<List<Map<String, dynamic>>> getCountryByCode({
    required String code,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/alpha/$code');
  }

  Future<List<Map<String, dynamic>>> getCountryByCodes({
    required List<String> codes,
  }) async {
    String formattedCodes = codes.map((String code) => code).toList().join(',');
    return await apiHelper.callAPI(
      apiUrl: '/alpha?codes=$formattedCodes',
    );
  }

  Future<List<Map<String, dynamic>>> getCountryByCurrency({
    required String currency,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/currency/$currency');
  }

  Future<List<Map<String, dynamic>>> getCountryByDemonym({
    required String demonym,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/demonym/$demonym');
  }

  Future<List<Map<String, dynamic>>> getCountryByLanguage({
    required String language,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/lang/$language');
  }

  Future<List<Map<String, dynamic>>> getCountryByRegion({
    required String region,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/region/$region');
  }

  Future<List<Map<String, dynamic>>> getCountryBySubRegion({
    required String subRegion,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/subregion/$subRegion');
  }

  Future<List<Map<String, dynamic>>> getCountryByTranslation({
    required String translation,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/translation/$translation');
  }

  Future<List<Map<String, dynamic>>> getCountryByFullName({
    required String fullName,
  }) async {
    return await apiHelper.callAPI(
      apiUrl: '/name/$fullName?fullText=true',
    );
  }

  Future<List<Map<String, dynamic>>> getCountriesByName({
    required String name,
  }) async {
    return await apiHelper.callAPI(apiUrl: '/name/$name');
  }

  Future<List<Map<String, dynamic>>> getCountriesByIndependentStatus({
    bool independent = true,
    List<CountryFields> fields = const <CountryFields>[],
  }) async {
    final String apiQueryFields = buildCountryQueryFields(
      countryFields: fields,
    );

    return await apiHelper.callAPI(
      apiUrl: '/independent?status=$independent&fields=$apiQueryFields',
    );
  }
}
