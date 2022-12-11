
import 'package:moontime/models/image.dart';
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

  static List<Episode> listFromJson(list) => List<Episode>.from(list.map((i) => Episode.fromJson(i)));
  /*static List<Episode> listFromJson(list) {
    print('listFromJson.length ${(list as List).length}');
    var decoded;
    // try{
    //   decoded     = json.decode(list as String);
    //
    // }catch(e){
    //   print('listFromJson.error $e');
    //   try{
    //     decoded     = (list);
    //
    //   }catch(e){
    //     print('listFromJson.error $e');
    //   }
    //
    // }
    decoded=List<Episode>.from(list.map((i) {
      print('listFromJson map  $i');
      var item;
      try{
        item= Episode.fromJson(i);

      }catch(e){
        print('listFromJson item error $e');

      }
      return item;

    }));


    print('listFromJson decoded $decoded');
    return decoded;
  }*/

  Episode.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        season = json['season'],
        number = json['number'] ?? 1,
        runtime = json['runtime'],
        url = json['url'],
        name = json['name'],
        type = json['type'],
        summary = json['summary'],
        language = json['language'],
        status = json['status'],
        airdate = DateTime.tryParse('${json['airdate']}'),
        airtime = json['airtime'],
        show = json['show'] != null ? Show.fromJson(json['show']) : null,
  image = json['image'] != null ? Image.fromJson(json['image']) : null;

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


