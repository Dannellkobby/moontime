class Network {
  late int id;
  String? name;
  Country? country;

  Network.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        country = Country.fromJson(json['country']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country?.toJson()
      }..removeWhere((key, value) => value == null);
}

class Country {
  String? name, code, timezone;

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        code = json['code'],
        timezone = json['timezone'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'timezone': timezone
      }..removeWhere((key, value) => value == null);
}
