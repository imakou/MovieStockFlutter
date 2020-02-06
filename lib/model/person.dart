// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

Person personFromJson(String str) => Person.fromJson(json.decode(str));

class Person {
  DateTime birthday;
  String knownForDepartment;
  int id;
  String name;
  int gender;
  String biography;
  String placeOfBirth;
  String profilePath;
  List<PersonPoster> poster;

  Person({
    this.birthday,
    this.knownForDepartment,
    this.id,
    this.name,
    this.gender,
    this.poster,
    this.biography,
    this.placeOfBirth,
    this.profilePath,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        birthday: json["birthday"] != null
            ? DateTime.parse(json["birthday"])
            : DateTime.parse('0000-00-00'),
        knownForDepartment: json["known_for_department"],
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        poster: json["poster"],
        biography: json["biography"],
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
      );
}

Future<Person> fetchPerson(int personID) async {
  final response = await http.get(
      'https://api.themoviedb.org/3/person/${personID}?api_key=62a63e99e24cf6c6b6793a961f73e879&language=en-US&include_image_language=en');
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    final result = json.decode(response.body);
    result['poster'] = await fetchPersonPoster(personID);
    return Person.fromJson(result);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load Movies');
  }
}

class PersonPoster {
  String filePath;
  String id;
  double voteAverage;
  Media media;
  String mediaType;

  PersonPoster({
    this.filePath,
    this.id,
    this.voteAverage,
    this.media,
    this.mediaType,
  });

  factory PersonPoster.fromJson(Map<String, dynamic> json) => PersonPoster(
        filePath: json["file_path"],
        id: json["id"],
        voteAverage: json["vote_average"].toDouble(),
        media: Media.fromJson(json["media"]),
        mediaType: json["media_type"],
      );
}

Future<List<PersonPoster>> fetchPersonPoster(int personID) async {
  final response = await http.get(
      'https://api.themoviedb.org/3/person/${personID}/tagged_images?api_key=62a63e99e24cf6c6b6793a961f73e879&language=en-US&page=1');
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    final result = json.decode(response.body);
    Iterable list = result['results'];
    final results = list.map((model) => PersonPoster.fromJson(model)).toList();
    return results;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load Movies');
  }
}

class Media {
  String backdropPath;
  int id;
  String overview;
  String posterPath;
  String title;
  double voteAverage;

  Media({
    this.backdropPath,
    this.id,
    this.overview,
    this.posterPath,
    this.title,
    this.voteAverage,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        title: json["original_title"],
        voteAverage: json["vote_average"].toDouble(),
      );
}
