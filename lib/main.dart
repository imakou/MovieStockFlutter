// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
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
  List<Movie> _movies = List<Movie>();

  @override
  void initState() {
    super.initState();
    _saveMoviesInState();
  }

  void _saveMoviesInState() {
    // Save Movies in state
    fetchMovies().then((movies) => {
          setState(() => {_movies = movies})
        });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text(_movies[index].title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'OpenSans',
          )),
      subtitle:
          Text(_movies[index].backdropPath, style: TextStyle(fontSize: 12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.grey[800],
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MoviesCarousel(_movies),
              PopularMoviesCarousel(_movies),
            ],
          ),
        ),
      ),
    ));
  }
}
