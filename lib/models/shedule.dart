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

