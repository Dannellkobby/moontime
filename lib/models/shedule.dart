/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

class Schedule {
   String? time;
   List<dynamic>? days;

   Schedule.fromJson(Map<String, dynamic> json)
      : time = json['time'],
         days = json['days'];

  Map<String, dynamic> toJson() => {
        'time': time,
        'days': days,
      }..removeWhere((key, value) => value == null);
}

