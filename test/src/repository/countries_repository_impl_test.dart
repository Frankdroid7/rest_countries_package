import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rest_countries/rest_countries.dart';
import 'package:rest_countries/src/data/countries_api.dart';
import 'package:rest_countries/src/repository/countries_repository_impl.dart';

class MockCountriesApi extends Mock implements CountriesApi {}

void main() {
  group('Test the methods in CountriesRepositoryImpl', () {
    late final List<Map<String, dynamic>> jsonData;
    late MockCountriesApi mockCountriesApi;
    late CountriesRepositoryImpl countriesRepositoryImpl;

    setUp(() {
      mockCountriesApi = MockCountriesApi();
      countriesRepositoryImpl = CountriesRepositoryImpl(mockCountriesApi);
    });

    setUpAll(() async {
      final File file = File('test/src/repository/mock_data.json');
      final String jsonStr = await file.readAsString();
      jsonData = List<Map<String, dynamic>>.from(jsonDecode(jsonStr));
    });

    test(
      'GIVEN getAllCountries is called, WHEN fields list is more than 10, THEN throw an exception ',
      () async {
        when(
          () => mockCountriesApi.getAllCountries(
            fields: List<CountryFields>.filled(11, CountryFields.name),
          ),
        ).thenThrow(Exception('Country fields cannot be more than 10'));

        expect(
          () async => await countriesRepositoryImpl.getAllCountries(
            fields: List<CountryFields>.filled(11, CountryFields.name),
          ),
          throwsA(
            predicate(
              (Object? e) =>
                  e is Exception &&
                  e.toString().contains(
                        'Country fields cannot be more than 10',
                      ),
            ),
          ),
        );
      },
    );

    test(
      "GIVEN valid fields, WHEN getAllCountries is called, THEN returns a List<CountryModel>",
      () async {
        when(
          () => mockCountriesApi
              .getAllCountries(fields: <CountryFields>[CountryFields.area]),
        ).thenAnswer(
          (_) =>
              Future<List<Map<String, dynamic>>>.value(<Map<String, dynamic>>[
            <String, dynamic>{
              "name": <String, Object>{
                "common": "Mayotte",
                "official": "Department of Mayotte",
                "nativeName": <String, Map<String, String>>{
                  "fra": <String, String>{
                    "official": "Department of Mayotte",
                    "common": "Mayotte",
                  },
                },
              },
            },
          ]),
        );

        final List<CountryModel> getAllCountries =
            await countriesRepositoryImpl.getAllCountries(
          fields: <CountryFields>[CountryFields.area],
        );

        expect(getAllCountries, isA<List<CountryModel>>());
        expect(getAllCountries.first.name?.common, 'Mayotte');
      },
    );

    test(
      "GIVEN valid fields, WHEN getCountriesByCapital is called, THEN verify that countriesApi.getCountriesByCapital is called",
      () async {
        when(
          () => mockCountriesApi.getCountriesByCapital(capital: 'Abuja'),
        ).thenAnswer((_) =>
            Future<List<Map<String, dynamic>>>.value(<Map<String, dynamic>>[]));
        await countriesRepositoryImpl.getCountriesByCapital(capital: 'Abuja');

        verify(
          () => mockCountriesApi.getCountriesByCapital(capital: 'Abuja'),
        ).called(1);
      },
    );

    test(
      'GIVEN valid fields, WHEN getCountryByCode is called, THEN verify CountryModel is returned',
      () async {
        when(
          () => mockCountriesApi.getCountryByCode(code: '170'),
        ).thenAnswer((_) => Future<List<Map<String, dynamic>>>.value(jsonData));

        final CountryModel getCountriesByCode =
            await countriesRepositoryImpl.getCountryByCode(code: '170');

        expect(getCountriesByCode, isA<CountryModel>());
      },
    );
    test(
      'GIVEN valid fields, WHEN getCountryByCode is called, THEN verify List<CountryModel> is returned',
      () async {
        when(
          () => mockCountriesApi.getCountryByCodes(codes: <String>['170']),
        ).thenAnswer((_) => Future<List<Map<String, dynamic>>>.value(jsonData));

        final List<CountryModel> getCountriesByCode =
            await countriesRepositoryImpl
                .getCountriesByCodes(codes: <String>['170']);

        expect(getCountriesByCode, isA<List<CountryModel>>());
      },
    );
    test(
      'GIVEN valid fields, WHEN getCountriesByCurrency is called and response is an empty list, THEN return an empty list',
      () async {
        when(
          () => mockCountriesApi.getCountryByCurrency(currency: 'NGN'),
        ).thenAnswer((_) =>
            Future<List<Map<String, dynamic>>>.value(<Map<String, dynamic>>[]));

        final List<CountryModel> getCountryByCurrency =
            await countriesRepositoryImpl.getCountriesByCurrency(
                currency: 'NGN');

        expect(getCountryByCurrency, isEmpty);
      },
    );
  });
}
