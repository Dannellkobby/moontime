class Image {
  String? medium, original;

  Image.fromJson(Map<String, dynamic> json)
      : medium = json['medium'],
        original = json['original'];

  Map<String, dynamic> toJson() => {'medium': medium, 'original': original}
    ..removeWhere((key, value) => value == null);
}
