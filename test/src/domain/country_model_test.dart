import 'package:rest_countries_data/rest_countries_data.dart';
import 'package:test/test.dart';

void main() {
  test(''' GIVEN CountryModel is returned, 
          WHEN getCountryPhoneNumberCode is called
          THEN return the accurate code''', () async {
    final CountryModel countryModel = CountryModel(
      idd: Idd(
        root: '+2',
        suffixes: <String>['34'],
      ),
    );

    expect(countryModel.getCountryPhoneNumberCode, '+234');
  });
}
