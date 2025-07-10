import 'package:flutter/foundation.dart';
import 'package:rest_countries_package/rest_countries.dart';

void main() async {
  await getCountriesByRegion();
  await getCountryByCode();
  await getCountriesByCurrency();
  await getAllCountries();
  await getCountriesByIndependentStatus();
}

void log(String message) {
  debugPrint(message);
}

Future<void> getCountriesByRegion() async {
  try {
    final countries = await RestCountries.getCountriesByRegion(region: 'Africa');
    log('\nCountries in Africa:');
    for (final country in countries) {
      log('- ${country.name?.common}');
    }
  } catch (e) {
    log('Error fetching countries by region: \$e');
  }
}

Future<void> getCountryByCode() async {
  try {
    final country = await RestCountries.getCountryByCode(code: 'NG');
    log('\nCountry with code NG: ${country.name?.official}');
  } catch (e) {
    log('Error fetching country by code: \$e');
  }
}

Future<void> getCountriesByCurrency() async {
  try {
    final countries = await RestCountries.getCountriesByCurrency(currency: 'USD');
    log('\nCountries using USD:');
    for (final country in countries) {
      log('- ${country.name?.common}');
    }
  } catch (e) {
    log('Error fetching countries by currency: \$e');
  }
}

Future<void> getAllCountries() async {
  try {
    final countries = await RestCountries.getAllCountries(fields: [CountryFields.name]);
    log('\nAll countries (limited fields):');
    for (final country in countries.take(5)) {
      log('- ${country.name?.common}');
    }
  } catch (e) {
    log('Error fetching all countries: \$e');
  }
}

Future<void> getCountriesByIndependentStatus() async {
  try {
    final countries = await RestCountries.getCountriesByIndependentStatus(independent: true);
    log('\nIndependent countries:');
    for (final country in countries.take(5)) {
      log('- ${country.name?.common}');
    }
  } catch (e) {
    log('Error fetching independent countries: \$e');
  }
}
