// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_app/model/cast.dart';
import 'package:http/http.dart' as http;

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<Genre> genreIds;
  List<Language> languages;
  String title;
  double voteAverage;
  String overview;
  DateTime releaseDate;
  List<Cast> casts;
  int runtime;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.casts,
    this.runtime,
    this.languages,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      popularity: json["popularity"].toDouble(),
      voteCount: json["vote_count"],
      video: json["video"],
      posterPath: json["poster_path"],
      id: json["id"],
      backdropPath: json["backdrop_path"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      genreIds: json["genres"] != null
          ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
          : [],
      title: json["title"],
      voteAverage: json["vote_average"].toDouble(),
      overview: json["overview"],
      releaseDate: DateTime.parse(json["release_date"]),
      casts: json["casts"],
      runtime: json['runtime'],
      languages: json["spoken_languages"] != null
          ? List<Language>.from(
              json["spoken_languages"].map((x) => Language.fromJson(x)))
          : []);
}

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(
      'https://api.themoviedb.org/3/movie/popular?api_key=62a63e99e24cf6c6b6793a961f73e879&language=en-US&include_image_language=en');
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    final result = json.decode(response.body);
    Iterable list = result['results'];
    final results = list.map((model) => Movie.fromJson(model)).toList();
    return results;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load Movies');
  }
}

Future<Movie> fetchMovie(movieID) async {
  final response = await http.get(
      'https://api.themoviedb.org/3/movie/${movieID}?api_key=62a63e99e24cf6c6b6793a961f73e879&language=en-US&include_image_language=en,null');
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    final result = json.decode(response.body);
    result['casts'] = await fetchCasts(result["id"]);
    final resultt = Movie.fromJson(result);
    return resultt;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load Movies');
  }
}

class Genre {
  int id;
  String name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Language {
  int iso_639_1;
  String name;

  Language({
    this.iso_639_1,
    this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        iso_639_1: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": iso_639_1,
        "name": name,
      };
}
