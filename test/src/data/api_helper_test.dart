import 'dart:convert';

import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rest_countries_data/src/data/api_helper.dart';

class MockApiHelper extends Mock implements ApiHelper {}

void main() {
  late MockApiHelper mockApiHelper;

  setUpAll(() {
    mockApiHelper = MockApiHelper();
  });
  group('API Helper', () {
    test(
      'GIVEN api url is correct, WHEN callAPI is called, THEN return a List<Map<String, dynamic>>',
      () async {
        final String url = 'https://restcountries.com/v3.1/all?fields=name';
        when(() => mockApiHelper.callAPI(apiUrl: url)).thenAnswer((_) =>
            Future<List<Map<String, dynamic>>>.value(
                List<Map<String, dynamic>>.from(jsonDecode(mockData))));

        List<Map<String, dynamic>> rest =
            await mockApiHelper.callAPI(apiUrl: url);

        expect(rest, isA<List<Map<String, dynamic>>>());
      },
    );

    test(
      'GIVEN api url has an unknown country, WHEN callAPI is called, THEN throw a country not found exception',
      () async {
        final String url = 'https://restcountries.com/v3.1/capital/bongo';
        when(() => mockApiHelper.callAPI(apiUrl: url))
            .thenThrow(Exception('Country not found'));

        expect(
          () => mockApiHelper.callAPI(apiUrl: url),
          throwsA(
            predicate(
              (Object? e) =>
                  e is Exception && e.toString().contains('Country not found'),
            ),
          ),
        );
      },
    );

    test(
      'GIVEN api url, WHEN callAPI is called and server fails, THEN throw a server error exception',
      () async {
        final String url = 'https://restcountries.com/v3.1/capital/paris';
        when(() => mockApiHelper.callAPI(apiUrl: url))
            .thenThrow(Exception('Server error'));

        expect(
          () => mockApiHelper.callAPI(apiUrl: url),
          throwsA(
            predicate(
              (Object? e) =>
                  e is Exception && e.toString().contains('Server error'),
            ),
          ),
        );
      },
    );

    test(
      'GIVEN country name endpoint, WHEN callAPI is called with valid name, THEN return a List<Map<String, dynamic>>',
      () async {
        final String url = 'https://restcountries.com/v3.1/name/nigeria';
        when(() => mockApiHelper.callAPI(apiUrl: url)).thenAnswer((_) =>
            Future<List<Map<String, dynamic>>>.value(
                List<Map<String, dynamic>>.from(jsonDecode(nigeriaData))));

        List<Map<String, dynamic>> result =
            await mockApiHelper.callAPI(apiUrl: url);

        expect(result, isA<List<Map<String, dynamic>>>());
      },
    );

    test(
      'GIVEN country code endpoint, WHEN callAPI is called with valid code, THEN return a List<Map<String, dynamic>>',
      () async {
        final String url = 'https://restcountries.com/v3.1/alpha/ng';
        when(() => mockApiHelper.callAPI(apiUrl: url)).thenAnswer((_) =>
            Future<List<Map<String, dynamic>>>.value(
                List<Map<String, dynamic>>.from(jsonDecode(nigeriaData))));

        List<Map<String, dynamic>> result =
            await mockApiHelper.callAPI(apiUrl: url);

        expect(result, isA<List<Map<String, dynamic>>>());
      },
    );

    test(
      'GIVEN currency endpoint, WHEN callAPI is called with valid currency, THEN return a List<Map<String, dynamic>>',
      () async {
        final String url = 'https://restcountries.com/v3.1/currency/usd';
        when(() => mockApiHelper.callAPI(apiUrl: url)).thenAnswer((_) =>
            Future<List<Map<String, dynamic>>>.value(
                List<Map<String, dynamic>>.from(jsonDecode(mockData))));

        List<Map<String, dynamic>> result =
            await mockApiHelper.callAPI(apiUrl: url);

        expect(result, isA<List<Map<String, dynamic>>>());
      },
    );

    test(
      'GIVEN language endpoint, WHEN callAPI is called with valid language, THEN return a List<Map<String, dynamic>>',
      () async {
        final String url = 'https://restcountries.com/v3.1/lang/french';
        when(() => mockApiHelper.callAPI(apiUrl: url)).thenAnswer((_) =>
            Future<List<Map<String, dynamic>>>.value(
                List<Map<String, dynamic>>.from(jsonDecode(mockData))));

        List<Map<String, dynamic>> result =
            await mockApiHelper.callAPI(apiUrl: url);

        expect(result, isA<List<Map<String, dynamic>>>());
      },
    );

    test(
      'GIVEN capital endpoint, WHEN callAPI is called with valid capital, THEN return a List<Map<String, dynamic>>',
      () async {
        final String url = 'https://restcountries.com/v3.1/capital/london';
        when(() => mockApiHelper.callAPI(apiUrl: url)).thenAnswer((_) =>
            Future<List<Map<String, dynamic>>>.value(
                List<Map<String, dynamic>>.from(jsonDecode(mockData))));

        List<Map<String, dynamic>> result =
            await mockApiHelper.callAPI(apiUrl: url);

        expect(result, isA<List<Map<String, dynamic>>>());
      },
    );
  });
}

String nigeriaData = """[
  {
    "name": {
      "common": "Nigeria",
      "official": "Federal Republic of Nigeria",
      "nativeName": {
        "eng": {"official": "Federal Republic of Nigeria", "common": "Nigeria"}
      }
    }
  }
]""";

String mockData = """[
  {
    "name": {
      "common": "Togo",
      "official": "Togolese Republic",
      "nativeName": {
        "fra": {"official": "Togolese Republic", "common": "Togo"}
      }
    }
  }
]""";
