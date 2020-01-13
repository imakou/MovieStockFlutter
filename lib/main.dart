// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/widgets/MoviesCarousel.dart';
import 'package:flutter_app/widgets/PopularMoviesCarousel.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      home: RestListDemo(),
    );
  }
  // #enddocregion build
}
// #enddocregion MyApp

class RestListDemo extends StatefulWidget {
  @override
  _RestListDemoState createState() => _RestListDemoState();
}

class _RestListDemoState extends State<RestListDemo> {
  List<Movie> _nowPlayingMovies = List<Movie>();
  List<Movie> _popularMovies = List<Movie>();

  @override
  void initState() {
    super.initState();
    _saveMoviesInState();
  }

  void _saveMoviesInState() {
    // Save Movies in state
    fetchMovies("now_playing").then((movies) => {
          setState(() => {_nowPlayingMovies = movies..shuffle()})
        });
    fetchMovies("popular").then((movies) => {
          setState(() => {_popularMovies = movies..shuffle()})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Colors.grey[800],
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MoviesCarousel(_nowPlayingMovies),
                PopularMoviesCarousel(_popularMovies),
              ],
            ),
          ),
        ));
  }
}
