import 'package:rest_countries/rest_countries.dart';

void main() async {
  await getCountriesByRegion();
  await getCountryByCode();
  await getCountriesByCurrency();
  await getAllCountries();
  await getCountriesByIndependentStatus();
}

void log(String message) {
  //ignore: avoid_print
  print(message);
}

Future<void> getCountriesByRegion() async {
  try {
    final List<CountryModel> countries = await RestCountries.getCountriesByRegion(region: 'Africa');
    log('\nCountries in Africa:');
    for (final CountryModel country in countries) {
      log('- ${country.name?.common}');
    }
  } catch (e) {
    log('$e');
  }
}

Future<void> getCountryByCode() async {
  try {
    final CountryModel country =
        await RestCountries.getCountryByCode(code: 'NG');
    log('\nCountry with code NG: ${country.name?.official}');
  } catch (e) {
    log('$e');
  }
}

Future<void> getCountriesByCurrency() async {
  try {
    final List<CountryModel> countries =
        await RestCountries.getCountriesByCurrency(currency: 'USD');
    log('\nCountries using USD:');
    for (final CountryModel country in countries) {
      log('- ${country.name?.common}');
    }
  } catch (e) {
    log('$e');
  }
}

Future<void> getAllCountries() async {
  try {
    final List<CountryModel> countries = await RestCountries.getAllCountries(
        fields: <CountryFields>[CountryFields.name]);
    log('\nAll countries (limited fields):');
    for (final CountryModel country in countries.take(5)) {
      log('- ${country.name?.common}');
    }
  } catch (e) {
    log('$e');
  }
}

Future<void> getCountriesByIndependentStatus() async {
  try {
    final List<CountryModel> countries =
        await RestCountries.getCountriesByIndependentStatus(independent: true);
    log('\nIndependent countries:');
    for (final CountryModel country in countries.take(5)) {
      log('- ${country.name?.common}');
    }
  } catch (e) {
    log('$e');
  }
}
