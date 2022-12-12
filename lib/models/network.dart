import 'package:moontime/models/country.dart';

/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

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


