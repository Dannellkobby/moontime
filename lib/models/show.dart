/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Image;
import 'package:moontime/models/network.dart';
import 'package:moontime/models/rating.dart';
import 'package:moontime/models/shedule.dart';
import 'image.dart';

class Show {
  late int id;
  int? runtime;
  Schedule? schedule;
  Rating? rating;
  late String url, name, type;
  String? language, status, summary;
  List? genres;
  Network? network;
  DateTime? premiered, ended;
  TimeOfDay? airtime;
  Image? image;

  static List<Show> listFromJson(list) =>
      List<Show>.from(list.map((i) => Show.fromJson(i)));
  static List<Show> listFromEmbeddedShowsJson(list) =>
      List<Show>.from(list.map((i) => Show.fromJson(i['_embedded']['show'])));

  Show.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        runtime = json['runtime'],
        name = json['name'],
        type = json['type'],
        rating =json['rating'] != null ? Rating.fromJson(json['rating']) : null,
        schedule =json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null,
        language = json['language'],
        genres = json['genres'],
        status = json['status'],
        summary = json['summary'],
        premiered = DateTime.tryParse('${json['premiered']}'),
        ended = DateTime.tryParse('${json['ended']}'),
        network =
            json['network'] != null ? Network.fromJson(json['network']) : null,
        image = json['image'] != null ? Image.fromJson(json['image']) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'runtime': runtime,
        'name': name,
        'rating': rating?.toJson(),
        'type': type,
        'language': language,
        'genres': genres,
        'status': status,
        'summary': summary,
        'schedule': schedule?.toJson(),
        'premiered': premiered.toString(),
        'ended': ended.toString(),
        'network': network?.toJson(),
        'image': image?.toJson()
      }..removeWhere((key, value) => value == null);
}
