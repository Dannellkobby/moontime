import 'package:moontime/models/network.dart';
import 'image.dart';

class Character {
  late int id;
  late String url, name;
  String? gender;
  Image? image;


  static List<Character> listFromJson(list) =>
      List<Character>.from(list.map((i) => Character.fromJson(i)));

  Character.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        name = json['name'],
        gender = json['gender'],
        image = json['image'] != null ? Image.fromJson(json['image']) : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'gender': gender,
    'name': name,
    'image': image?.toJson(),
  }..removeWhere((key, value) => value == null);
}
