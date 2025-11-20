import 'package:test/test.dart';
import 'package:rest_countries_data/src/domain/enums/country_fields.dart';

void main() {
  group('CountryFields enum extension tests', () {
    group('apiValue property tests', () {
      test('name field returns correct api value', () {
        expect(CountryFields.name.apiValue, equals('name'));
      });

      test('cca2 field returns correct api value', () {
        expect(CountryFields.cca2.apiValue, equals('cca2'));
      });

      test('cca3 field returns correct api value', () {
        expect(CountryFields.cca3.apiValue, equals('cca3'));
      });

      test('ccn3 field returns correct api value', () {
        expect(CountryFields.ccn3.apiValue, equals('ccn3'));
      });

      test('cioc field returns correct api value', () {
        expect(CountryFields.cioc.apiValue, equals('cioc'));
      });

      test('independent field returns correct api value', () {
        expect(CountryFields.independent.apiValue, equals('independent'));
      });

      test('status field returns correct api value', () {
        expect(CountryFields.status.apiValue, equals('status'));
      });

      test('flag field returns correct api value', () {
        expect(CountryFields.flag.apiValue, equals('flag'));
      });

      test('unMember field returns correct api value', () {
        expect(CountryFields.unMember.apiValue, equals('unMember'));
      });

      test('capital field returns correct api value', () {
        expect(CountryFields.capital.apiValue, equals('capital'));
      });

      test('region field returns correct api value', () {
        expect(CountryFields.region.apiValue, equals('region'));
      });

      test('subregion field returns correct api value', () {
        expect(CountryFields.subregion.apiValue, equals('subregion'));
      });

      test('continents field returns correct api value', () {
        expect(CountryFields.continents.apiValue, equals('continents'));
      });

      test('population field returns correct api value', () {
        expect(CountryFields.population.apiValue, equals('population'));
      });

      test('area field returns correct api value', () {
        expect(CountryFields.area.apiValue, equals('area'));
      });

      test('gini field returns correct api value', () {
        expect(CountryFields.gini.apiValue, equals('gini'));
      });

      test('timezones field returns correct api value', () {
        expect(CountryFields.timezones.apiValue, equals('timezones'));
      });

      test('topLevelDomain field returns "tld" as api value', () {
        expect(CountryFields.topLevelDomain.apiValue, equals('tld'));
      });

      test('latlng field returns correct api value', () {
        expect(CountryFields.latlng.apiValue, equals('latlng'));
      });

      test('demonym field returns correct api value', () {
        expect(CountryFields.demonym.apiValue, equals('demonym'));
      });

      test('borders field returns correct api value', () {
        expect(CountryFields.borders.apiValue, equals('borders'));
      });

      test('currencies field returns correct api value', () {
        expect(CountryFields.currencies.apiValue, equals('currencies'));
      });

      test('idd field returns correct api value', () {
        expect(CountryFields.idd.apiValue, equals('idd'));
      });

      test('languages field returns correct api value', () {
        expect(CountryFields.languages.apiValue, equals('languages'));
      });

      test('translations field returns correct api value', () {
        expect(CountryFields.translations.apiValue, equals('translations'));
      });

      test('flags field returns correct api value', () {
        expect(CountryFields.flags.apiValue, equals('flags'));
      });

      test('regionalBlocs field returns correct api value', () {
        expect(CountryFields.regionalBlocs.apiValue, equals('regionalBlocs'));
      });

      test('altSpellings field returns correct api value', () {
        expect(CountryFields.altSpellings.apiValue, equals('altSpellings'));
      });

      test('capitalInfo field returns correct api value', () {
        expect(CountryFields.capitalInfo.apiValue, equals('capitalInfo'));
      });

      test('car field returns correct api value', () {
        expect(CountryFields.car.apiValue, equals('car'));
      });

      test('coatOfArms field returns correct api value', () {
        expect(CountryFields.coatOfArms.apiValue, equals('coatOfArms'));
      });

      test('demonyms field returns correct api value', () {
        expect(CountryFields.demonyms.apiValue, equals('demonyms'));
      });

      test('fifa field returns correct api value', () {
        expect(CountryFields.fifa.apiValue, equals('fifa'));
      });

      test('maps field returns correct api value', () {
        expect(CountryFields.maps.apiValue, equals('maps'));
      });

      test('startOfWeek field returns correct api value', () {
        expect(CountryFields.startOfWeek.apiValue, equals('startOfWeek'));
      });

      test('landlocked field returns correct api value', () {
        expect(CountryFields.landlocked.apiValue, equals('landlocked'));
      });
    });

    group('buildCountryQueryFields function tests', () {
      test('empty list returns empty string', () {
        final String result =
            buildCountryQueryFields(countryFields: <CountryFields>[]);
        expect(result, equals(''));
      });

      test('single field returns single value', () {
        final String result = buildCountryQueryFields(
          countryFields: <CountryFields>[CountryFields.name],
        );
        expect(result, equals('name'));
      });

      test('multiple fields returns comma-separated values', () {
        final String result = buildCountryQueryFields(
          countryFields: <CountryFields>[
            CountryFields.name,
            CountryFields.capital,
            CountryFields.population,
          ],
        );
        expect(result, equals('name,capital,population'));
      });

      test('fields with different api values are correctly mapped', () {
        final String result = buildCountryQueryFields(
          countryFields: <CountryFields>[
            CountryFields.topLevelDomain,
            CountryFields.cca2,
          ],
        );
        expect(result, equals('tld,cca2'));
      });

      test('large list of fields returns correctly formatted string', () {
        final String result = buildCountryQueryFields(
          countryFields: <CountryFields>[
            CountryFields.name,
            CountryFields.capital,
            CountryFields.region,
            CountryFields.subregion,
            CountryFields.population,
            CountryFields.area,
            CountryFields.languages,
            CountryFields.currencies,
            CountryFields.flags,
            CountryFields.borders,
          ],
        );
        expect(
          result,
          equals(
              'name,capital,region,subregion,population,area,languages,currencies,flags,borders'),
        );
      });

      test('duplicate fields are preserved in output', () {
        final String result = buildCountryQueryFields(
          countryFields: <CountryFields>[
            CountryFields.name,
            CountryFields.name,
            CountryFields.capital,
          ],
        );
        expect(result, equals('name,name,capital'));
      });

      test('all enum values can be converted', () {
        final List<CountryFields> allFields = CountryFields.values;
        final String result = buildCountryQueryFields(countryFields: allFields);

        // Verify no exceptions and result is not empty
        expect(result.isNotEmpty, isTrue);
        expect(result.split(',').length, equals(allFields.length));
      });
    });
  });
}
