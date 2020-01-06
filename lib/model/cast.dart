// To parse this JSON data, do
//
//     final cast = castFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

Cast castFromJson(String str) => Cast.fromJson(json.decode(str));

class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        profilePath: json["profile_path"],
      );
}

Future<List<Cast>> fetchCasts(movieID) async {
  final response = await http.get(
      'https://api.themoviedb.org/3/movie/${movieID}/credits?api_key=62a63e99e24cf6c6b6793a961f73e879&language=en-US');
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    final result = json.decode(response.body);
    Iterable list = result['cast'];
    final results = list.map((model) => Cast.fromJson(model)).toList();
    return results;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load Credits');
  }
}
