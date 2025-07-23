# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-07-16

- 🎉 Initial release of `rest_countries_data` Dart package.
- Provides a wrapper around the [restcountries.com](https://restcountries.com) API.
- Features include:
  - `getAllCountries` with field filtering (max 10)
  - `getCountryByCode`, `getCountriesByCodes`
  - `getCountriesByCurrency`, `getCountriesByLanguage`
  - `getCountriesByCapital`, `getCountriesByRegion`, `getCountriesBySubRegion`
  - `getCountryByName`, `getCountryByFullName`
  - `getCountriesByTranslation`
  - `getCountriesByDemonym`
  - `getCountriesByIndependentStatus`
- Includes example usage in `/example` folder.

## [1.0.1] - 2025-07-23
### Changed
- Moved conditional logic from the service layer to the repository layer.
- Updated tests to reflect logic change.

### Added
- Image added to README.
