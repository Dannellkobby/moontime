/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:moontime/models/country.dart';
import 'image.dart';

class Person {
  late int id;
  late String url, name;
  String? gender;
  DateTime? birthday;
  DateTime? deathday;
  Country? country;
  Image? image;

  static List<Person> listFromJson(list) =>
      List<Person>.from(list.map((i) => Person.fromJson(i)));

  Person.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        name = json['name'],
        gender = json['gender'],
        birthday = DateTime.tryParse('${json['birthday']}'),
        deathday = DateTime.tryParse('${json['deathday']}'),
        country =
            json['country'] != null ? Country.fromJson(json['country']) : null,
        image = json['image'] != null ? Image.fromJson(json['image']) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'gender': gender,
        'name': name,
        'birthday': birthday.toString(),
        'deathday': deathday.toString(),
        'country': country?.toJson(),
        'image': image?.toJson(),
      }..removeWhere((key, value) => value == null);
}
