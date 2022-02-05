class CountryInfo {
  String? dialCode;
  String? shortName;
  String? name;
  String? displayName;

  CountryInfo({this.dialCode, this.shortName, this.name, this.displayName});

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
