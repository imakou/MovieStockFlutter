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
  final _bottomNavigationColor = Colors.white;
  int _currentIndex = 0;

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
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.grey[700],
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.movie,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.subject,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_box,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '',
                )),
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
