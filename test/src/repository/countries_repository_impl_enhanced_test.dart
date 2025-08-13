import 'dart:io';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rest_countries_data/rest_countries_data.dart';
import 'package:rest_countries_data/src/data/countries_api.dart';
import 'package:rest_countries_data/src/repository/countries_repository_impl.dart';

class MockCountriesApi extends Mock implements CountriesApi {}

void main() {
  group('CountriesRepositoryImpl - Additional Tests', () {
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

    group('getAllCountries tests', () {
      test(
        'GIVEN empty fields list, WHEN getAllCountries is called, THEN throw exception',
        () async {
          expect(
            () async => await countriesRepositoryImpl.getAllCountries(
              fields: <CountryFields>[],
            ),
            throwsA(
              predicate(
                (Object? e) =>
                    e is Exception &&
                    e.toString().contains('CountryFields cannot be empty'),
              ),
            ),
          );
        },
      );

      test(
        'GIVEN exactly 10 fields, WHEN getAllCountries is called, THEN returns successfully',
        () async {
          when(
            () => mockCountriesApi.getAllCountries(fields: any(named: 'fields')),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{
                  'name': <String, Object>{'common': 'Test', 'official': 'Test Official'}
                }
              ],
            ),
          );

          final result = await countriesRepositoryImpl.getAllCountries(
            fields: List<CountryFields>.filled(10, CountryFields.name),
          );

          expect(result, isA<List<CountryModel>>());
        },
      );

      test(
        'GIVEN multiple countries returned, WHEN getAllCountries is called, THEN all are converted to CountryModel',
        () async {
          when(
            () => mockCountriesApi.getAllCountries(fields: any(named: 'fields')),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{'name': <String, Object>{'common': 'Country 1'}},
                <String, dynamic>{'name': <String, Object>{'common': 'Country 2'}},
                <String, dynamic>{'name': <String, Object>{'common': 'Country 3'}},
              ],
            ),
          );

          final result = await countriesRepositoryImpl.getAllCountries(
            fields: <CountryFields>[CountryFields.name],
          );

          expect(result.length, equals(3));
          expect(result[0].name?.common, equals('Country 1'));
          expect(result[1].name?.common, equals('Country 2'));
          expect(result[2].name?.common, equals('Country 3'));
        },
      );
    });

    group('getCountryByDemonym tests', () {
      test(
        'GIVEN valid demonym, WHEN getCountriesByDemonym is called, THEN returns List<CountryModel>',
        () async {
          when(
            () => mockCountriesApi.getCountryByDemonym(demonym: 'American'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByDemonym(demonym: 'American');

          expect(result, isA<List<CountryModel>>());
          verify(() => mockCountriesApi.getCountryByDemonym(demonym: 'American'))
              .called(1);
        },
      );

      test(
        'GIVEN demonym with no results, WHEN getCountriesByDemonym is called, THEN returns empty list',
        () async {
          when(
            () => mockCountriesApi.getCountryByDemonym(demonym: 'NonExistent'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(<Map<String, dynamic>>[]),
          );

          final result = await countriesRepositoryImpl.getCountriesByDemonym(
              demonym: 'NonExistent');

          expect(result, isEmpty);
        },
      );
    });

    group('getCountriesByLanguage tests', () {
      test(
        'GIVEN valid language code, WHEN getCountriesByLanguage is called, THEN returns List<CountryModel>',
        () async {
          when(
            () => mockCountriesApi.getCountryByLanguage(language: 'eng'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByLanguage(language: 'eng');

          expect(result, isA<List<CountryModel>>());
          verify(() => mockCountriesApi.getCountryByLanguage(language: 'eng'))
              .called(1);
        },
      );

      test(
        'GIVEN multiple countries with same language, WHEN getCountriesByLanguage is called, THEN returns all countries',
        () async {
          when(
            () => mockCountriesApi.getCountryByLanguage(language: 'spa'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{'name': <String, Object>{'common': 'Spain'}},
                <String, dynamic>{'name': <String, Object>{'common': 'Mexico'}},
              ],
            ),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByLanguage(language: 'spa');

          expect(result.length, equals(2));
        },
      );
    });

    group('getCountriesByRegion tests', () {
      test(
        'GIVEN valid region, WHEN getCountriesByRegion is called, THEN returns List<CountryModel>',
        () async {
          when(
            () => mockCountriesApi.getCountryByRegion(region: 'Africa'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByRegion(region: 'Africa');

          expect(result, isA<List<CountryModel>>());
          verify(() => mockCountriesApi.getCountryByRegion(region: 'Africa'))
              .called(1);
        },
      );

      test(
        'GIVEN region with multiple countries, WHEN getCountriesByRegion is called, THEN returns all countries in region',
        () async {
          when(
            () => mockCountriesApi.getCountryByRegion(region: 'Europe'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              List.generate(
                10,
                (i) => <String, dynamic>{
                  'name': <String, Object>{'common': 'Country $i'}
                },
              ),
            ),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByRegion(region: 'Europe');

          expect(result.length, equals(10));
        },
      );
    });

    group('getCountriesBySubRegion tests', () {
      test(
        'GIVEN valid subregion, WHEN getCountriesBySubRegion is called, THEN returns List<CountryModel>',
        () async {
          when(
            () => mockCountriesApi.getCountryBySubRegion(subRegion: 'Western Africa'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          final result = await countriesRepositoryImpl.getCountriesBySubRegion(
              subRegion: 'Western Africa');

          expect(result, isA<List<CountryModel>>());
          verify(() =>
                  mockCountriesApi.getCountryBySubRegion(subRegion: 'Western Africa'))
              .called(1);
        },
      );
    });

    group('getCountriesByTranslation tests', () {
      test(
        'GIVEN valid translation, WHEN getCountriesByTranslation is called, THEN returns List<CountryModel>',
        () async {
          when(
            () => mockCountriesApi.getCountryByTranslation(translation: 'Deutschland'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          final result = await countriesRepositoryImpl.getCountriesByTranslation(
              translation: 'Deutschland');

          expect(result, isA<List<CountryModel>>());
          verify(() => mockCountriesApi.getCountryByTranslation(
              translation: 'Deutschland')).called(1);
        },
      );
    });

    group('getCountryByFullName tests', () {
      test(
        'GIVEN valid full name, WHEN getCountryByFullName is called, THEN returns single CountryModel',
        () async {
          when(
            () => mockCountriesApi.getCountryByFullName(
                fullName: 'Federal Republic of Nigeria'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          final result = await countriesRepositoryImpl.getCountryByFullName(
              fullName: 'Federal Republic of Nigeria');

          expect(result, isA<CountryModel>());
          verify(() => mockCountriesApi.getCountryByFullName(
              fullName: 'Federal Republic of Nigeria')).called(1);
        },
      );

      test(
        'GIVEN full name, WHEN getCountryByFullName is called, THEN returns first item from API response',
        () async {
          when(
            () => mockCountriesApi.getCountryByFullName(fullName: 'United Kingdom'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{
                  'name': <String, Object>{'common': 'UK'}
                },
              ],
            ),
          );

          final result = await countriesRepositoryImpl.getCountryByFullName(
              fullName: 'United Kingdom');

          expect(result.name?.common, equals('UK'));
        },
      );
    });

    group('getCountriesByName tests', () {
      test(
        'GIVEN partial name, WHEN getCountriesByName is called, THEN returns List<CountryModel>',
        () async {
          when(
            () => mockCountriesApi.getCountriesByName(name: 'United'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByName(name: 'United');

          expect(result, isA<List<CountryModel>>());
          verify(() => mockCountriesApi.getCountriesByName(name: 'United'))
              .called(1);
        },
      );

      test(
        'GIVEN name matching multiple countries, WHEN getCountriesByName is called, THEN returns all matching countries',
        () async {
          when(
            () => mockCountriesApi.getCountriesByName(name: 'United'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{
                  'name': <String, Object>{'common': 'United States'}
                },
                <String, dynamic>{
                  'name': <String, Object>{'common': 'United Kingdom'}
                },
                <String, dynamic>{
                  'name': <String, Object>{'common': 'United Arab Emirates'}
                },
              ],
            ),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByName(name: 'United');

          expect(result.length, equals(3));
        },
      );
    });

    group('getCountriesByIndependentStatus tests', () {
      test(
        'GIVEN independent=true, WHEN getCountriesByIndependentStatus is called, THEN returns List<CountryModel>',
        () async {
          when(
            () => mockCountriesApi.getCountriesByIndependentStatus(
              independent: true,
              fields: <CountryFields>[],
            ),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByIndependentStatus(
            independent: true,
            fields: <CountryFields>[],
          );

          expect(result, isA<List<CountryModel>>());
          verify(() => mockCountriesApi.getCountriesByIndependentStatus(
              independent: true, fields: <CountryFields>[])).called(1);
        },
      );

      test(
        'GIVEN independent=false, WHEN getCountriesByIndependentStatus is called, THEN returns non-independent countries',
        () async {
          when(
            () => mockCountriesApi.getCountriesByIndependentStatus(
              independent: false,
              fields: <CountryFields>[],
            ),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{
                  'name': <String, Object>{'common': 'Puerto Rico'},
                  'independent': false
                },
              ],
            ),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByIndependentStatus(
            independent: false,
            fields: <CountryFields>[],
          );

          expect(result.length, equals(1));
          expect(result.first.name?.common, equals('Puerto Rico'));
        },
      );

      test(
        'GIVEN fields specified, WHEN getCountriesByIndependentStatus is called, THEN passes fields to API',
        () async {
          when(
            () => mockCountriesApi.getCountriesByIndependentStatus(
              independent: true,
              fields: <CountryFields>[CountryFields.name, CountryFields.capital],
            ),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          await countriesRepositoryImpl.getCountriesByIndependentStatus(
            independent: true,
            fields: <CountryFields>[CountryFields.name, CountryFields.capital],
          );

          verify(() => mockCountriesApi.getCountriesByIndependentStatus(
              independent: true,
              fields: <CountryFields>[
                CountryFields.name,
                CountryFields.capital
              ])).called(1);
        },
      );

      test(
        'GIVEN default parameters, WHEN getCountriesByIndependentStatus is called, THEN uses independent=true and empty fields',
        () async {
          when(
            () => mockCountriesApi.getCountriesByIndependentStatus(
              independent: true,
              fields: <CountryFields>[],
            ),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(jsonData),
          );

          await countriesRepositoryImpl.getCountriesByIndependentStatus();

          verify(() => mockCountriesApi.getCountriesByIndependentStatus(
              independent: true, fields: <CountryFields>[])).called(1);
        },
      );
    });

    group('getCountryByCapital additional tests', () {
      test(
        'GIVEN capital name, WHEN getCountryByCapital is called, THEN returns single CountryModel',
        () async {
          when(
            () => mockCountriesApi.getCountryByCapital(capital: 'London'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{
                  'name': <String, Object>{'common': 'United Kingdom'},
                  'capital': ['London']
                },
              ],
            ),
          );

          final result =
              await countriesRepositoryImpl.getCountryByCapital(capital: 'London');

          expect(result, isA<CountryModel>());
          expect(result.name?.common, equals('United Kingdom'));
        },
      );
    });

    group('getCountryByCode additional tests', () {
      test(
        'GIVEN two-letter code, WHEN getCountryByCode is called, THEN returns single CountryModel',
        () async {
          when(
            () => mockCountriesApi.getCountryByCode(code: 'US'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{
                  'name': <String, Object>{'common': 'United States'},
                  'cca2': 'US'
                },
              ],
            ),
          );

          final result =
              await countriesRepositoryImpl.getCountryByCode(code: 'US');

          expect(result, isA<CountryModel>());
          expect(result.cca2, equals('US'));
        },
      );
    });

    group('getCountriesByCodes additional tests', () {
      test(
        'GIVEN single code in list, WHEN getCountriesByCodes is called, THEN returns List<CountryModel> with one item',
        () async {
          when(
            () => mockCountriesApi.getCountryByCodes(codes: <String>['NG']),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{'name': <String, Object>{'common': 'Nigeria'}},
              ],
            ),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByCodes(codes: <String>['NG']);

          expect(result.length, equals(1));
          expect(result.first.name?.common, equals('Nigeria'));
        },
      );

      test(
        'GIVEN multiple codes, WHEN getCountriesByCodes is called, THEN returns List<CountryModel> with multiple items',
        () async {
          when(
            () =>
                mockCountriesApi.getCountryByCodes(codes: <String>['US', 'CA', 'MX']),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{
                  'name': <String, Object>{'common': 'United States'}
                },
                <String, dynamic>{'name': <String, Object>{'common': 'Canada'}},
                <String, dynamic>{'name': <String, Object>{'common': 'Mexico'}},
              ],
            ),
          );

          final result = await countriesRepositoryImpl.getCountriesByCodes(
              codes: <String>['US', 'CA', 'MX']);

          expect(result.length, equals(3));
        },
      );
    });

    group('getCountriesByCurrency additional tests', () {
      test(
        'GIVEN valid currency, WHEN getCountriesByCurrency is called, THEN returns List<CountryModel>',
        () async {
          when(
            () => mockCountriesApi.getCountryByCurrency(currency: 'EUR'),
          ).thenAnswer(
            (_) => Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[
                <String, dynamic>{'name': <String, Object>{'common': 'Germany'}},
                <String, dynamic>{'name': <String, Object>{'common': 'France'}},
              ],
            ),
          );

          final result =
              await countriesRepositoryImpl.getCountriesByCurrency(currency: 'EUR');

          expect(result.length, equals(2));
          expect(result, isA<List<CountryModel>>());
        },
      );
    });
  });
}
