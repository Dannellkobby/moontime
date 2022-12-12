/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

class Image {
  String? medium, original;

  Image.fromJson(Map<String, dynamic> json)
      : medium = json['medium'],
        original = json['original'];

  Map<String, dynamic> toJson() => {'medium': medium, 'original': original}
    ..removeWhere((key, value) => value == null);
}
