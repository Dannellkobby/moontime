/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

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