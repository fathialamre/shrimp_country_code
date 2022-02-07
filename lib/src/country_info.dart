import 'package:flutter/cupertino.dart';
import 'package:shrimp_country_code/src/strings/ar.dart';
import 'package:shrimp_country_code/src/strings/en.dart';

class CountryInfo {
  String? dialCode;
  String? shortName;
  String? name;
  String? displayName;

  CountryInfo({this.dialCode, this.shortName, this.name, this.displayName});

  String get flagUrl {
    return 'flags/${shortName.toString().toLowerCase()}.png';
  }

  String localizedName(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    if (myLocale.languageCode == 'ar') {
      return ar[shortName] ?? 'لا توجد دولة';
    }
    return en[shortName] ?? 'No country found';
  }

  CountryInfo.fromJson(Map<String, dynamic> json) {
    dialCode = json['dial_code'];
    shortName = json['short_name'];
    name = json['name'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dial_code'] = dialCode;
    data['short_name'] = shortName;
    data['name'] = name;
    data['display_name'] = displayName;
    return data;
  }
}
