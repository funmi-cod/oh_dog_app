// To parse this JSON data, do
//
//     final dogBreed = dogBreedFromJson(jsonString);

import 'dart:convert';

DogBreed dogBreedFromJson(String str) => DogBreed.fromJson(json.decode(str));

String dogBreedToJson(DogBreed data) => json.encode(data.toJson());

class DogBreed {
  List<String>? message;
  String? status;

  DogBreed({
    this.message,
    this.status,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) => DogBreed(
        message: json["message"] == null
            ? []
            : List<String>.from(json["message"]!.map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message":
            message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
        "status": status,
      };
}
