# rest_countries_data

<p align="center">
  <img src="assets/images/country_logo.png" alt="rest_countries_data Logo" width="200"/>
</p>

---

A Dart wrapper around the [REST Countries v3.1 API](https://restcountries.com) that provides a fully-typed, developer-friendly interface for accessing detailed country data.

---

## ✨ Features

- Get all countries with selected fields (limited to 10 fields)
- Query countries by:
  - Capital
  - Full name or partial name
  - ISO 3166-1 code or list of codes
  - Region / Subregion
  - Language / Currency / Demonym
  - Translation
  - Independence status
- Built-in `CountryModel` to map the API response
- Enum-based `CountryFields` selector for fine-grained queries
- Clean separation of concerns via Repository, API and Domain layers

---

## 🚀 Getting Started

### 1. Install the Package

Add to your `pubspec.yaml`:

```yaml
dependencies:
  rest_countries_data: ^1.0.0
```

Then run:

```bash
# For Dart users
dart pub get

# For Flutter users
flutter pub get
```

### 2. Import It

```dart
import 'package:rest_countries_data/rest_countries_data.dart';
```

---

## 📦 Usage

### Fetch All Countries with Selected Fields

```dart
final countries = await RestCountries.getAllCountries(
  fields: [CountryFields.name, CountryFields.capital, CountryFields.region],
);
```
## Field Limitation ⚠️
When using the `fields` parameter in methods like `getAllCountries`, the maximum number of allowed fields is **10**. This limit is enforced by the [REST Countries API](https://restcountries.com/).

Also note: Whenever you specify the fields property, the properties that will be available in the returned `CountryModel` depend entirely on which `CountryFields` you request. If you omit a field, the corresponding property in `CountryModel` may be `null`.



### Get Countries by Capital

```dart
final countries = await RestCountries.getCountriesByCapital(capital: 'Paris');
```

### Get a Country by ISO Code

```dart
final country = await RestCountries.getCountryByCode(code: 'NG');
```

### Get Countries by Currency

```dart
final countries = await RestCountries.getCountriesByCurrency(currency: 'USD');
```

### Get Countries by Region

```dart
final countries = await RestCountries.getCountriesByRegion(region: 'Europe');
```

### Get Countries by SubRegion

```dart
final countries = await RestCountries.getCountriesBySubRegion(subRegion: 'Eastern Africa');
```

### Get Country by Full Name

```dart
final country = await RestCountries.getCountryByFullName(fullName: 'Federal Republic of Nigeria');
```

### Get Countries by Language, Demonym, or Translation

```dart
final countries = await RestCountries.getCountriesByLanguage(language: 'en');
final countries = await RestCountries.getCountriesByDemonym(demonym: 'Nigerian');
final countries = await RestCountries.getCountriesByTranslation(translation: 'Niger');
```

### Get Countries by Independence Status

```dart
final countries = await RestCountries.getCountriesByIndependentStatus(
  independent: true,
  fields: [CountryFields.name, CountryFields.flag],
);
```

---

## 📚 Data Model

### CountryModel (Simplified)

```dart
class CountryModel {
  final Name? name;
  final List<String>? capital;
  final String? region;
  final String? subregion;
  final Map<String, dynamic>? flags;
  // ...
}

class Name {
  final String common;
  final String official;
  final Map<String, NativeName>? nativeName;
}
```

### CountryFields Enum

Use the `CountryFields` enum to limit which fields are returned from the API:

```dart
CountryFields.name
CountryFields.capital
CountryFields.region
CountryFields.area
CountryFields.languages
// etc.
```

**Note**: Maximum 10 fields per request for `getAllCountries()`

---

## 🔍 API Overview

| Method                                   | Description                                  |
| ---------------------------------------- | -------------------------------------------- |
| `getAllCountries({required fields})`              | Get all countries with selected fields       |
| `getCountriesByCapital(capital)`         | Filter by capital city                       |
| `getCountryByCode(code)`                 | Get a single country by ISO code             |
| `getCountriesByCodes(codes)`             | Get multiple countries by ISO codes          |
| `getCountriesByCurrency(currency)`       | Filter by currency                           |
| `getCountriesByDemonym(demonym)`         | Filter by demonym                            |
| `getCountriesByLanguage(language)`       | Filter by spoken language                    |
| `getCountriesByRegion(region)`           | Filter by region                             |
| `getCountriesBySubRegion(subRegion)`     | Filter by subregion                          |
| `getCountriesByTranslation(translation)` | Filter by translated country name            |
| `getCountryByFullName(fullName)`         | Get a country by its full name               |
| `getCountriesByName(name)`               | Filter by partial or full name               |
| `getCountriesByIndependentStatus(...)`   | Filter by independence and optionally fields |

---

## 📊 Example (Run it)

```dart
import 'package:rest_countries_data/rest_countries_data.dart';

void main() async {
  final countries = await RestCountries.getCountriesByRegion(region: 'Africa');

  for (var country in countries) {
    print(country.name?.common);
  }
}
```

---

## 🚪 Contributing

Pull requests are welcome! If you have ideas or find bugs, feel free to open an issue.

---

## 👋 Author

Maintained by [Franklin Oladipo](https://github.com/frankdroid7)

---

## 📄 License

[BSD 3-Clause](LICENSE)
