import 'package:test/test.dart';
import 'package:rest_countries_data/rest_countries_data.dart';

void main() {
  group('CountryModel Tests', () {
    group('fromJson factory constructor', () {
      test('creates CountryModel from complete JSON', () {
        final json = {
          'name': {
            'common': 'Nigeria',
            'official': 'Federal Republic of Nigeria',
            'nativeName': {
              'eng': {'official': 'Federal Republic of Nigeria', 'common': 'Nigeria'}
            }
          },
          'cca2': 'NG',
          'cca3': 'NGA',
          'ccn3': '566',
          'cioc': 'NGR',
          'independent': true,
          'status': 'officially-assigned',
          'unMember': true,
          'capital': ['Abuja'],
          'region': 'Africa',
          'subregion': 'Western Africa',
          'continents': ['Africa'],
          'population': 206139587,
          'area': 923768.0,
          'gini': {'2018': 35.1},
          'timezones': ['UTC+01:00'],
          'tld': ['.ng'],
          'latlng': [10.0, 8.0],
          'demonym': 'Nigerian',
          'borders': ['BEN', 'CMR', 'TCD', 'NER'],
          'currencies': {
            'NGN': {'name': 'Nigerian naira', 'symbol': '₦'}
          },
          'idd': {
            'root': '+2',
            'suffixes': ['34']
          },
          'languages': {'eng': 'English'},
          'translations': {
            'fra': {'official': 'République fédérale du Nigeria', 'common': 'Nigeria'}
          },
          'flags': {'svg': 'https://flagcdn.com/ng.svg', 'png': 'https://flagcdn.com/w320/ng.png'},
          'fifa': 'NGA',
          'landlocked': false,
          'flag': '🇳🇬',
          'startOfWeek': 'monday',
          'capitalInfo': {
            'latlng': [9.08, 7.53]
          },
          'car': {
            'signs': ['WAN'],
            'side': 'right'
          },
          'coatOfArms': {
            'png': 'https://mainfacts.com/media/images/coats_of_arms/ng.png',
            'svg': 'https://mainfacts.com/media/images/coats_of_arms/ng.svg'
          },
          'maps': {
            'googleMaps': 'https://goo.gl/maps/LTn417qWwBPFszuV9',
            'openStreetMaps': 'https://www.openstreetmap.org/relation/192787'
          },
          'demonyms': {
            'eng': {'f': 'Nigerian', 'm': 'Nigerian'}
          }
        };

        final country = CountryModel.fromJson(json);

        expect(country.name?.common, equals('Nigeria'));
        expect(country.cca2, equals('NG'));
        expect(country.cca3, equals('NGA'));
        expect(country.ccn3, equals('566'));
        expect(country.cioc, equals('NGR'));
        expect(country.independent, isTrue);
        expect(country.status, equals('officially-assigned'));
        expect(country.unMember, isTrue);
        expect(country.capital, equals(['Abuja']));
        expect(country.region, equals('Africa'));
        expect(country.subregion, equals('Western Africa'));
        expect(country.population, equals(206139587));
        expect(country.area, equals(923768.0));
        expect(country.fifa, equals('NGA'));
        expect(country.landlocked, isFalse);
        expect(country.flag, equals('🇳🇬'));
        expect(country.startOfWeek, equals('monday'));
      });

      test('creates CountryModel with null fields when JSON is incomplete', () {
        final json = {
          'name': {'common': 'Test Country'}
        };

        final country = CountryModel.fromJson(json);

        expect(country.name?.common, equals('Test Country'));
        expect(country.cca2, isNull);
        expect(country.capital, isNull);
        expect(country.population, isNull);
        expect(country.currencies, isNull);
      });

      test('handles area as integer and converts to double', () {
        final json = {
          'name': {'common': 'Test'},
          'area': 100
        };

        final country = CountryModel.fromJson(json);

        expect(country.area, equals(100.0));
        expect(country.area, isA<double>());
      });

      test('handles area as double', () {
        final json = {
          'name': {'common': 'Test'},
          'area': 100.5
        };

        final country = CountryModel.fromJson(json);

        expect(country.area, equals(100.5));
      });

      test('handles empty lists correctly', () {
        final json = {
          'name': {'common': 'Test'},
          'capital': [],
          'borders': [],
          'timezones': []
        };

        final country = CountryModel.fromJson(json);

        expect(country.capital, isEmpty);
        expect(country.borders, isEmpty);
        expect(country.timezones, isEmpty);
      });
    });

    group('getCountryPhoneNumberCode getter', () {
      test('returns concatenated phone code with root and suffixes', () {
        final country = CountryModel(
          idd: Idd(root: '+2', suffixes: ['34']),
        );

        expect(country.getCountryPhoneNumberCode, equals('+234'));
      });

      test('returns concatenated code with multiple suffixes', () {
        final country = CountryModel(
          idd: Idd(root: '+1', suffixes: ['242', '246']),
        );

        expect(country.getCountryPhoneNumberCode, equals('+1242246'));
      });

      test('handles null suffixes', () {
        final country = CountryModel(
          idd: Idd(root: '+44', suffixes: null),
        );

        expect(country.getCountryPhoneNumberCode, equals('+44null'));
      });

      test('handles null root', () {
        final country = CountryModel(
          idd: Idd(root: null, suffixes: ['123']),
        );

        expect(country.getCountryPhoneNumberCode, equals('null123'));
      });

      test('handles null idd', () {
        final country = CountryModel(idd: null);

        expect(country.getCountryPhoneNumberCode, equals('nullnull'));
      });
    });

    group('toString method', () {
      test('returns formatted string representation', () {
        final country = CountryModel(
          name: Name(common: 'Nigeria'),
          cca2: 'NG',
          population: 206139587,
        );

        final result = country.toString();

        expect(result, contains('CountryModel'));
        expect(result, contains('name:'));
        expect(result, contains('cca2: NG'));
        expect(result, contains('population: 206139587'));
      });
    });
  });

  group('Name Model Tests', () {
    test('fromJson creates Name with all fields', () {
      final json = {
        'common': 'Nigeria',
        'official': 'Federal Republic of Nigeria',
        'nativeName': {
          'eng': {'official': 'Federal Republic of Nigeria', 'common': 'Nigeria'}
        }
      };

      final name = Name.fromJson(json);

      expect(name.common, equals('Nigeria'));
      expect(name.official, equals('Federal Republic of Nigeria'));
      expect(name.nativeName, isNotNull);
      expect(name.nativeName?['eng']?.common, equals('Nigeria'));
    });

    test('toString returns formatted string', () {
      final name = Name(common: 'Test', official: 'Test Official');
      final result = name.toString();

      expect(result, contains('Name'));
      expect(result, contains('common: Test'));
      expect(result, contains('official: Test Official'));
    });
  });

  group('Currency Model Tests', () {
    test('fromJson creates Currency with name and symbol', () {
      final json = {'name': 'Nigerian naira', 'symbol': '₦'};

      final currency = Currency.fromJson(json);

      expect(currency.name, equals('Nigerian naira'));
      expect(currency.symbol, equals('₦'));
    });

    test('toString returns formatted string', () {
      final currency = Currency(name: 'US Dollar', symbol: '\$');
      final result = currency.toString();

      expect(result, contains('Currency'));
      expect(result, contains('name: US Dollar'));
      expect(result, contains('symbol: \$'));
    });
  });

  group('Idd Model Tests', () {
    test('fromJson creates Idd with root and suffixes', () {
      final json = {
        'root': '+2',
        'suffixes': ['34', '35']
      };

      final idd = Idd.fromJson(json);

      expect(idd.root, equals('+2'));
      expect(idd.suffixes, equals(['34', '35']));
    });

    test('toString returns formatted string', () {
      final idd = Idd(root: '+1', suffixes: ['123']);
      final result = idd.toString();

      expect(result, contains('Idd'));
      expect(result, contains('root: +1'));
      expect(result, contains('suffixes:'));
    });
  });

  group('Translation Model Tests', () {
    test('fromJson creates Translation', () {
      final json = {'official': 'Official Name', 'common': 'Common Name'};

      final translation = Translation.fromJson(json);

      expect(translation.official, equals('Official Name'));
      expect(translation.common, equals('Common Name'));
    });

    test('toString returns formatted string', () {
      final translation = Translation(official: 'Off', common: 'Com');
      final result = translation.toString();

      expect(result, contains('Translation'));
    });
  });

  group('Flags Model Tests', () {
    test('fromJson creates Flags with svg and png', () {
      final json = {'svg': 'flag.svg', 'png': 'flag.png'};

      final flags = Flags.fromJson(json);

      expect(flags.svg, equals('flag.svg'));
      expect(flags.png, equals('flag.png'));
    });

    test('toString returns formatted string', () {
      final flags = Flags(svg: 'test.svg', png: 'test.png');
      final result = flags.toString();

      expect(result, contains('Flags'));
      expect(result, contains('svg:'));
      expect(result, contains('png:'));
    });
  });

  group('RegionalBloc Model Tests', () {
    test('fromJson creates RegionalBloc with all fields', () {
      final json = {
        'acronym': 'EU',
        'name': 'European Union',
        'otherAcronyms': ['EEC'],
        'otherNames': ['European Economic Community']
      };

      final bloc = RegionalBloc.fromJson(json);

      expect(bloc.acronym, equals('EU'));
      expect(bloc.name, equals('European Union'));
      expect(bloc.otherAcronyms, equals(['EEC']));
      expect(bloc.otherNames, equals(['European Economic Community']));
    });

    test('toString returns formatted string', () {
      final bloc = RegionalBloc(acronym: 'AU', name: 'African Union');
      final result = bloc.toString();

      expect(result, contains('RegionalBloc'));
      expect(result, contains('acronym: AU'));
    });
  });

  group('CapitalInfo Model Tests', () {
    test('fromJson creates CapitalInfo with latlng', () {
      final json = {
        'latlng': [9.08, 7.53]
      };

      final capitalInfo = CapitalInfo.fromJson(json);

      expect(capitalInfo.latlng, equals([9.08, 7.53]));
    });

    test('handles integer values in latlng', () {
      final json = {
        'latlng': [9, 7]
      };

      final capitalInfo = CapitalInfo.fromJson(json);

      expect(capitalInfo.latlng, equals([9.0, 7.0]));
    });

    test('toString returns formatted string', () {
      final capitalInfo = CapitalInfo(latlng: [1.0, 2.0]);
      final result = capitalInfo.toString();

      expect(result, contains('CapitalInfo'));
      expect(result, contains('latlng:'));
    });
  });

  group('Car Model Tests', () {
    test('fromJson creates Car with signs and side', () {
      final json = {
        'signs': ['WAN'],
        'side': 'right'
      };

      final car = Car.fromJson(json);

      expect(car.signs, equals(['WAN']));
      expect(car.side, equals('right'));
    });

    test('toString returns formatted string', () {
      final car = Car(signs: ['USA'], side: 'right');
      final result = car.toString();

      expect(result, contains('Car'));
      expect(result, contains('signs:'));
      expect(result, contains('side: right'));
    });
  });

  group('CoatOfArms Model Tests', () {
    test('fromJson creates CoatOfArms', () {
      final json = {'png': 'coat.png', 'svg': 'coat.svg'};

      final coatOfArms = CoatOfArms.fromJson(json);

      expect(coatOfArms.png, equals('coat.png'));
      expect(coatOfArms.svg, equals('coat.svg'));
    });

    test('toString returns formatted string', () {
      final coatOfArms = CoatOfArms(png: 'test.png', svg: 'test.svg');
      final result = coatOfArms.toString();

      expect(result, contains('CoatOfArms'));
    });
  });

  group('GenderedDemonym Model Tests', () {
    test('fromJson creates GenderedDemonym', () {
      final json = {'f': 'Nigerian', 'm': 'Nigerian'};

      final demonym = GenderedDemonym.fromJson(json);

      expect(demonym.f, equals('Nigerian'));
      expect(demonym.m, equals('Nigerian'));
    });

    test('toString returns formatted string', () {
      final demonym = GenderedDemonym(f: 'American', m: 'American');
      final result = demonym.toString();

      expect(result, contains('GenderedDemonym'));
      expect(result, contains('f:'));
      expect(result, contains('m:'));
    });
  });

  group('Maps Model Tests', () {
    test('fromJson creates Maps with googleMaps and openStreetMaps', () {
      final json = {
        'googleMaps': 'https://goo.gl/maps/test',
        'openStreetMaps': 'https://www.openstreetmap.org/test'
      };

      final maps = Maps.fromJson(json);

      expect(maps.googleMaps, equals('https://goo.gl/maps/test'));
      expect(maps.openStreetMaps, equals('https://www.openstreetmap.org/test'));
    });

    test('toString returns formatted string', () {
      final maps = Maps(googleMaps: 'google', openStreetMaps: 'osm');
      final result = maps.toString();

      expect(result, contains('Maps'));
      expect(result, contains('googleMaps:'));
      expect(result, contains('openStreetMaps:'));
    });
  });
}
