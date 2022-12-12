/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

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