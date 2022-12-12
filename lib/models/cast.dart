/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:moontime/models/character.dart';
import 'package:moontime/models/person.dart';

class Cast {
  Person? person;
  Character? character;
  bool? self;
  bool? voice;

  Cast({this.person});

  Cast.fromJson(Map<String, dynamic> json)
      : voice = json['voice'],
        self = json['self'],
        character = json['character'] != null ? Character.fromJson(json['character']) : null,
        person = json['person'] != null ? Person.fromJson(json['person']) : null;

  Map<String, dynamic> toJson() => {
    'voice': voice,
    'self': self,
    'person': person?.toJson(),
    'character': character?.toJson(),
  }..removeWhere((key, value) => value == null);


  static List<Cast> listFromJson(list) =>
      List<Cast>.from(list.map((i) => Cast.fromJson(i)));
}
