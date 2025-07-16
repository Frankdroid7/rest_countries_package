import 'package:rest_countries/src/domain/country_model.dart';
import 'package:rest_countries/src/domain/enums/country_fields.dart';

abstract class CountryRepository {
  Future<List<CountryModel>> getAllCountries({
    required List<CountryFields> fields,
  });

  Future<List<CountryModel>> getCountriesByName({required String name});

  Future<CountryModel> getCountryByFullName({required String fullName});

  Future<CountryModel> getCountryByCode({required String code});

  Future<List<CountryModel>> getCountriesByCodes({required List<String> codes});

  Future<List<CountryModel>> getCountriesByCurrency({required String currency});

  Future<List<CountryModel>> getCountriesByDemonym({required String demonym});

  Future<List<CountryModel>> getCountriesByLanguage({required String language});

  Future<List<CountryModel>> getCountriesByCapital({required String capital});

  Future<List<CountryModel>> getCountriesByRegion({required String region});

  Future<List<CountryModel>> getCountriesBySubRegion({
    required String subRegion,
  });

  Future<List<CountryModel>> getCountriesByTranslation({
    required String translation,
  });

  Future<List<CountryModel>> getCountriesByIndependentStatus({
    bool independent = true,
    List<CountryFields> fields = const <CountryFields>[],
  });
}
