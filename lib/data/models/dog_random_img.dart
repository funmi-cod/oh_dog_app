// To parse this JSON data, do
//
//     final dogRandomImg = dogRandomImgFromJson(jsonString);

import 'dart:convert';

DogRandomImg dogRandomImgFromJson(String str) =>
    DogRandomImg.fromJson(json.decode(str));

String dogRandomImgToJson(DogRandomImg data) => json.encode(data.toJson());

class DogRandomImg {
  String? message;
  String? status;

  DogRandomImg({
    this.message,
    this.status,
  });

  factory DogRandomImg.fromJson(Map<String, dynamic> json) => DogRandomImg(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
