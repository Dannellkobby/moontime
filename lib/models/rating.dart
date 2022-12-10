import 'dart:math';

class Rating {
  double? average;
  Rating.fromJson(Map<String, dynamic> json)
      : average = double.tryParse('${json['average']}')?? Random()
      .nextInt(10)
      .clamp(5, 10).toDouble();

  Map<String, dynamic> toJson() =>
      {'average': average};

}