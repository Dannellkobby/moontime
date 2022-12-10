import 'package:flutter/material.dart' hide Image;
import 'package:moontime/models/image.dart';
import 'package:moontime/models/show.dart';

class Episode {
  late int id, season, number, runtime;
  late String url, name;
  String? type, summary, language, status;
  DateTime? airdate;
  TimeOfDay? airtime;
   Show? show;
  Image? image;
  // static List<Episode> listFromJson(list) => List<Episode>.from(list.map((i) => Episode.fromJson(i)));
  static List<Episode> listFromJson(list) => List<Episode>.from(list.map((i) => Episode.fromJson(i)));

  Episode.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        season = json['season'],
        number = json['number']??1,
        runtime = json['runtime'],
        url = json['url'],
        name = json['name'],
        type = json['type'],
        summary = json['summary'],
        language = json['language'],
        status = json['status'],
        airdate = DateTime.tryParse('${json['airdate']} ${json['airtime']}'),
        airtime = json['airtime'] != null ? TimeOfDay.fromDateTime(DateTime.parse('${json['airdate']} ${json['airtime']}')) : null,
        show = json['show']!=null? Show.fromJson(json['show']):null;

  Map<String, dynamic> toJson() =>
      {'id': id,
        'season': season,
        'number': number,
        'url': url,
        'runtime': runtime,
        'name': name,
        'type': type,
        'language': language,
        'status': status,
        'summary': summary,
        'airdate': airdate?.toString(),
        'airtime': airtime?.toString(),
        'show': show?.toJson(),
        'image': image?.toJson()
      }
        ..removeWhere((key, value) => value == null);
}


