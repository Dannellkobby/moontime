/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:moontime/models/image.dart';
import 'package:moontime/models/rating.dart';
import 'package:moontime/models/show.dart';

class Episode {
  late int id, season, number;
  late String url, name;
  int? runtime;
  String? type, summary, language, status;
  DateTime? airdate;
  String? airtime;
  Show? show;
  Image? image;
  Rating? rating;

  static List<Episode> listFromJson(list) =>
      List<Episode>.from(list.map((i) => Episode.fromJson(i)));

  Episode.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        season = json['season'] ?? 1,
        number = json['number'] ?? 1,
        runtime = json['runtime'],
        url = json['url'],
        name = json['name'],
        type = json['type'],
        rating =
            json['rating'] != null ? Rating.fromJson(json['rating']) : null,
        summary = json['summary'],
        language = json['language'],
        status = json['status'],
        airdate = DateTime.tryParse('${json['airdate']}'),
        airtime = json['airtime'],
        show = json['show'] != null ? Show.fromJson(json['show']) : null,
        image = json['image'] != null ? Image.fromJson(json['image']) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'season': season,
        'number': number,
        'url': url,
        'runtime': runtime,
        'name': name,
        'type': type,
        'language': language,
        'rating': rating?.toJson(),
        'status': status,
        'summary': summary,
        'airdate': airdate?.toString(),
        'airtime': airtime?.toString(),
        'show': show?.toJson(),
        'image': image?.toJson()
      }..removeWhere((key, value) => value == null);
}
