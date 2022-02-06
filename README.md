## Shrimp Country Code
A flutter package for showing a country code selector.
## Usage

To use this plugin, add shrimp_country_code as a dependency in your pubspec.yaml.

Just put the component in your application setting the onChanged callback.

```dart
ShrimpCountryCode(
    modalTitle: 'Countries',
    initialCountry: 'LY',
    showFlags: false,
    searchFieldHint: 'Search by country name',
    onChanged: (CountryInfo country) {
    if (kDebugMode) {
        print(country.toJson());
        }
    },
)
```
# Customization

| Name | Type | Description |
| ------ | ------ | -------|
| onChange | ValueChanged | callback invoked when the selection changes |
| modalTitle | String | Modal title |
| inputDecoration | InputDecoration | Search text box decoration

# Support the Library
You can support the library by staring it on Github && liking it on pub or report any bugs you encounter.
also, if you have a suggestion or think something can be implemented in a better way, open an issue and let's talk about it.

## License
MIT
