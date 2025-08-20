import 'package:test/test.dart';
import 'package:rest_countries_data/rest_countries_data.dart';

void main() {
  group('CountryModel Tests', () {
    group('fromJson factory constructor', () {
      test('creates CountryModel from complete JSON', () {
        final Map<String, Object> json = <String, Object>{
          'name': <String, Object>{
            'common': 'Nigeria',
            'official': 'Federal Republic of Nigeria',
            'nativeName': <String, Map<String, String>>{
              'eng': <String, String>{
                'official': 'Federal Republic of Nigeria',
                'common': 'Nigeria'
              }
            }
          },
          'cca2': 'NG',
          'cca3': 'NGA',
          'ccn3': '566',
          'cioc': 'NGR',
          'independent': true,
          'status': 'officially-assigned',
          'unMember': true,
          'capital': <String>['Abuja'],
          'region': 'Africa',
          'subregion': 'Western Africa',
          'continents': <String>['Africa'],
          'population': 206139587,
          'area': 923768.0,
          'gini': <String, double>{'2018': 35.1},
          'timezones': <String>['UTC+01:00'],
          'tld': <String>['.ng'],
          'latlng': <double>[10.0, 8.0],
          'demonym': 'Nigerian',
          'borders': <String>['BEN', 'CMR', 'TCD', 'NER'],
          'currencies': <String, Map<String, String>>{
            'NGN': <String, String>{'name': 'Nigerian naira', 'symbol': '₦'}
          },
          'idd': <String, Object>{
            'root': '+2',
            'suffixes': <String>['34']
          },
          'languages': <String, String>{'eng': 'English'},
          'translations': <String, Map<String, String>>{
            'fra': <String, String>{
              'official': 'République fédérale du Nigeria',
              'common': 'Nigeria'
            }
          },
          'flags': <String, String>{
            'svg': 'https://flagcdn.com/ng.svg',
            'png': 'https://flagcdn.com/w320/ng.png'
          },
          'fifa': 'NGA',
          'landlocked': false,
          'flag': '🇳🇬',
          'startOfWeek': 'monday',
          'capitalInfo': <String, List<double>>{
            'latlng': <double>[9.08, 7.53]
          },
          'car': <String, Object>{
            'signs': <String>['WAN'],
            'side': 'right'
          },
          'coatOfArms': <String, String>{
            'png': 'https://mainfacts.com/media/images/coats_of_arms/ng.png',
            'svg': 'https://mainfacts.com/media/images/coats_of_arms/ng.svg'
          },
          'maps': <String, String>{
            'googleMaps': 'https://goo.gl/maps/LTn417qWwBPFszuV9',
            'openStreetMaps': 'https://www.openstreetmap.org/relation/192787'
          },
          'demonyms': <String, Map<String, String>>{
            'eng': <String, String>{'f': 'Nigerian', 'm': 'Nigerian'}
          }
        };

        final CountryModel country = CountryModel.fromJson(json);

        expect(country.name?.common, equals('Nigeria'));
        expect(country.cca2, equals('NG'));
        expect(country.cca3, equals('NGA'));
        expect(country.ccn3, equals('566'));
        expect(country.cioc, equals('NGR'));
        expect(country.independent, isTrue);
        expect(country.status, equals('officially-assigned'));
        expect(country.unMember, isTrue);
        expect(country.capital, equals(<String>['Abuja']));
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
        final Map<String, Object> json = <String, Object>{
          'name': <String, String>{'common': 'Test Country'}
        };

        final CountryModel country = CountryModel.fromJson(json);

        expect(country.name?.common, equals('Test Country'));
        expect(country.cca2, isNull);
        expect(country.capital, isNull);
        expect(country.population, isNull);
        expect(country.currencies, isNull);
      });

      test('handles area as integer and converts to double', () {
        final Map<String, Object> json = <String, Object>{
          'name': <String, String>{'common': 'Test'},
          'area': 100
        };

        final CountryModel country = CountryModel.fromJson(json);

        expect(country.area, equals(100.0));
        expect(country.area, isA<double>());
      });

      test('handles area as double', () {
        final Map<String, Object> json = <String, Object>{
          'name': <String, String>{'common': 'Test'},
          'area': 100.5
        };

        final CountryModel country = CountryModel.fromJson(json);

        expect(country.area, equals(100.5));
      });

      test('handles empty lists correctly', () {
        final Map<String, Object> json = <String, Object>{
          'name': <String, String>{'common': 'Test'},
          'capital': <String>[],
          'borders': <String>[],
          'timezones': <String>[]
        };

        final CountryModel country = CountryModel.fromJson(json);

        expect(country.capital, isEmpty);
        expect(country.borders, isEmpty);
        expect(country.timezones, isEmpty);
      });
    });

    group('getCountryPhoneNumberCode getter', () {
      test('returns concatenated phone code with root and suffixes', () {
        final CountryModel country = CountryModel(
          idd: Idd(root: '+2', suffixes: <String>['34']),
        );

        expect(country.getCountryPhoneNumberCode, equals('+234'));
      });

      test('returns concatenated code with multiple suffixes', () {
        final CountryModel country = CountryModel(
          idd: Idd(root: '+1', suffixes: <String>['242', '246']),
        );

        expect(country.getCountryPhoneNumberCode, equals('+1242246'));
      });

      test('handles null suffixes', () {
        final CountryModel country = CountryModel(
          idd: Idd(root: '+44', suffixes: null),
        );

        expect(country.getCountryPhoneNumberCode, equals('+44null'));
      });

      test('handles null root', () {
        final CountryModel country = CountryModel(
          idd: Idd(root: null, suffixes: <String>['123']),
        );

        expect(country.getCountryPhoneNumberCode, equals('null123'));
      });

      test('handles null idd', () {
        final CountryModel country = CountryModel(idd: null);

        expect(country.getCountryPhoneNumberCode, equals('nullnull'));
      });
    });

    group('toString method', () {
      test('returns formatted string representation', () {
        final String country = CountryModel(
          name: Name(common: 'Nigeria'),
          cca2: 'NG',
          population: 206139587,
        ).toString();

        expect(country, contains('CountryModel'));
        expect(country, contains('name:'));
        expect(country, contains('cca2: NG'));
        expect(country, contains('population: 206139587'));
      });
    });
  });

  group('Name Model Tests', () {
    test('fromJson creates Name with all fields', () {
      final Map<String, Object> json = <String, Object>{
        'common': 'Nigeria',
        'official': 'Federal Republic of Nigeria',
        'nativeName': <String, Object>{
          'eng': <String, String>{
            'official': 'Federal Republic of Nigeria',
            'common': 'Nigeria'
          }
        }
      };

      final Name name = Name.fromJson(json);

      expect(name.common, equals('Nigeria'));
      expect(name.official, equals('Federal Republic of Nigeria'));
      expect(name.nativeName, isNotNull);
      expect(name.nativeName?['eng']?.common, equals('Nigeria'));
    });

    test('toString returns formatted string', () {
      final Name name = Name(common: 'Test', official: 'Test Official');
      final String result = name.toString();

      expect(result, contains('Name'));
      expect(result, contains('common: Test'));
      expect(result, contains('official: Test Official'));
    });
  });

  group('Currency Model Tests', () {
    test('fromJson creates Currency with name and symbol', () {
      final Map<String, String> json = <String, String>{
        'name': 'Nigerian naira',
        'symbol': '₦'
      };

      final Currency currency = Currency.fromJson(json);

      expect(currency.name, equals('Nigerian naira'));
      expect(currency.symbol, equals('₦'));
    });

    test('toString returns formatted string', () {
      final Currency currency = Currency(name: 'US Dollar', symbol: '\$');
      final String result = currency.toString();

      expect(result, contains('Currency'));
      expect(result, contains('name: US Dollar'));
      expect(result, contains('symbol: \$'));
    });
  });

  group('Idd Model Tests', () {
    test('fromJson creates Idd with root and suffixes', () {
      final Map<String, Object> json = <String, Object>{
        'root': '+2',
        'suffixes': <String>['34', '35']
      };

      final Idd idd = Idd.fromJson(json);

      expect(idd.root, equals('+2'));
      expect(idd.suffixes, equals(<String>['34', '35']));
    });

    test('toString returns formatted string', () {
      final Idd idd = Idd(root: '+1', suffixes: <String>['123']);
      final String result = idd.toString();

      expect(result, contains('Idd'));
      expect(result, contains('root: +1'));
      expect(result, contains('suffixes:'));
    });
  });

  group('Translation Model Tests', () {
    test('fromJson creates Translation', () {
      final Map<String, String> json = <String, String>{
        'official': 'Official Name',
        'common': 'Common Name'
      };

      final Translation translation = Translation.fromJson(json);

      expect(translation.official, equals('Official Name'));
      expect(translation.common, equals('Common Name'));
    });

    test('toString returns formatted string', () {
      final Translation translation =
          Translation(official: 'Off', common: 'Com');
      final String result = translation.toString();

      expect(result, contains('Translation'));
    });
  });

  group('Flags Model Tests', () {
    test('fromJson creates Flags with svg and png', () {
      final Map<String, String> json = <String, String>{
        'svg': 'flag.svg',
        'png': 'flag.png'
      };

      final Flags flags = Flags.fromJson(json);

      expect(flags.svg, equals('flag.svg'));
      expect(flags.png, equals('flag.png'));
    });

    test('toString returns formatted string', () {
      final Flags flags = Flags(svg: 'test.svg', png: 'test.png');
      final String result = flags.toString();

      expect(result, contains('Flags'));
      expect(result, contains('svg:'));
      expect(result, contains('png:'));
    });
  });

  group('RegionalBloc Model Tests', () {
    test('fromJson creates RegionalBloc with all fields', () {
      final Map<String, Object> json = <String, Object>{
        'acronym': 'EU',
        'name': 'European Union',
        'otherAcronyms': <String>['EEC'],
        'otherNames': <String>['European Economic Community']
      };

      final RegionalBloc bloc = RegionalBloc.fromJson(json);

      expect(bloc.acronym, equals('EU'));
      expect(bloc.name, equals('European Union'));
      expect(bloc.otherAcronyms, equals(<String>['EEC']));
      expect(bloc.otherNames, equals(<String>['European Economic Community']));
    });

    test('toString returns formatted string', () {
      final RegionalBloc bloc =
          RegionalBloc(acronym: 'AU', name: 'African Union');
      final String result = bloc.toString();

      expect(result, contains('RegionalBloc'));
      expect(result, contains('acronym: AU'));
    });
  });

  group('CapitalInfo Model Tests', () {
    test('fromJson creates CapitalInfo with latlng', () {
      final Map<String, List<double>> json = <String, List<double>>{
        'latlng': <double>[9.08, 7.53]
      };

      final CapitalInfo capitalInfo = CapitalInfo.fromJson(json);

      expect(capitalInfo.latlng, equals(<double>[9.08, 7.53]));
    });

    test('handles integer values in latlng', () {
      final Map<String, List<int>> json = <String, List<int>>{
        'latlng': <int>[9, 7]
      };

      final CapitalInfo capitalInfo = CapitalInfo.fromJson(json);

      expect(capitalInfo.latlng, equals(<double>[9.0, 7.0]));
    });

    test('toString returns formatted string', () {
      final CapitalInfo capitalInfo = CapitalInfo(latlng: <double>[1.0, 2.0]);
      final String result = capitalInfo.toString();

      expect(result, contains('CapitalInfo'));
      expect(result, contains('latlng:'));
    });
  });

  group('Car Model Tests', () {
    test('fromJson creates Car with signs and side', () {
      final Map<String, Object> json = <String, Object>{
        'signs': <String>['WAN'],
        'side': 'right'
      };

      final Car car = Car.fromJson(json);

      expect(car.signs, equals(<String>['WAN']));
      expect(car.side, equals('right'));
    });

    test('toString returns formatted string', () {
      final Car car = Car(signs: <String>['USA'], side: 'right');
      final String result = car.toString();

      expect(result, contains('Car'));
      expect(result, contains('signs:'));
      expect(result, contains('side: right'));
    });
  });

  group('CoatOfArms Model Tests', () {
    test('fromJson creates CoatOfArms', () {
      final Map<String, String> json = <String, String>{
        'png': 'coat.png',
        'svg': 'coat.svg'
      };

      final CoatOfArms coatOfArms = CoatOfArms.fromJson(json);

      expect(coatOfArms.png, equals('coat.png'));
      expect(coatOfArms.svg, equals('coat.svg'));
    });

    test('toString returns formatted string', () {
      final CoatOfArms coatOfArms =
          CoatOfArms(png: 'test.png', svg: 'test.svg');
      final String result = coatOfArms.toString();

      expect(result, contains('CoatOfArms'));
    });
  });

  group('GenderedDemonym Model Tests', () {
    test('fromJson creates GenderedDemonym', () {
      final Map<String, String> json = <String, String>{
        'f': 'Nigerian',
        'm': 'Nigerian'
      };

      final GenderedDemonym demonym = GenderedDemonym.fromJson(json);

      expect(demonym.f, equals('Nigerian'));
      expect(demonym.m, equals('Nigerian'));
    });

    test('toString returns formatted string', () {
      final GenderedDemonym demonym =
          GenderedDemonym(f: 'American', m: 'American');
      final String result = demonym.toString();

      expect(result, contains('GenderedDemonym'));
      expect(result, contains('f:'));
      expect(result, contains('m:'));
    });
  });

  group('Maps Model Tests', () {
    test('fromJson creates Maps with googleMaps and openStreetMaps', () {
      final Map<String, String> json = <String, String>{
        'googleMaps': 'https://goo.gl/maps/test',
        'openStreetMaps': 'https://www.openstreetmap.org/test'
      };

      final Maps maps = Maps.fromJson(json);

      expect(maps.googleMaps, equals('https://goo.gl/maps/test'));
      expect(maps.openStreetMaps, equals('https://www.openstreetmap.org/test'));
    });

    test('toString returns formatted string', () {
      final Maps maps = Maps(googleMaps: 'google', openStreetMaps: 'osm');
      final String result = maps.toString();

      expect(result, contains('Maps'));
      expect(result, contains('googleMaps:'));
      expect(result, contains('openStreetMaps:'));
    });
  });
}
