import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rest_countries/src/data/api_helper.dart';

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
            Future.value(
                List<Map<String, dynamic>>.from(jsonDecode(mockData))));

        var rest = await mockApiHelper.callAPI(apiUrl: url);

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
              (e) =>
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
              (e) =>
                  e is Exception && e.toString().contains('Server error'),
            ),
          ),
        );
      },
    );
  });
}

var mockData = """[
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
