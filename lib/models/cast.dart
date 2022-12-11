import 'package:moontime/models/character.dart';
import 'package:moontime/models/person.dart';

class Cast {
  Person? person;
  Character? character;
  bool? self;
  bool? voice;



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
