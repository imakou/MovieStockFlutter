import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/cast.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/widgets/CastsPageView.dart';
import 'package:intl/intl.dart';

import 'cast_list_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieID;
  MovieDetailScreen({Key key, this.movieID}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie _movie;
  @override
  void initState() {
    // TODO: implement initState
    fetchMovie(widget.movieID).then((movie) => {
          print(movie.genreIds),
          print("movie.cast:${movie.casts[0].name}"),
          setState(() {
            _movie = movie;
          })
        });
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
  }

  @override
  Widget build(BuildContext context) {
    if (_movie is Movie) {
      return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w1280/${_movie.backdropPath}'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.darken)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              color: Colors.white,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35.0),
                                topRight: Radius.circular(35.0)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(top: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _movie.title,
                                            style: TextStyle(
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.0, bottom: 10, top: 10),
                                            child: Text(
                                              '${DateFormat('yyyy').format(_movie.releaseDate)} | ${durationToString(_movie.runtime)} | ${_movie.languages[0].name}',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  letterSpacing: 1,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Wrap(
                                              alignment: WrapAlignment.start,
                                              children: _movie.genreIds
                                                  .map((genre) => Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.yellow,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      8),
                                                          child:
                                                              Text(genre.name),
                                                        ),
                                                      ))
                                                  .toList()),
                                        ],
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Synopsis",
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            letterSpacing: 1.3,
                                            height: 1.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(_movie.overview),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Casts",
                                            style: TextStyle(
                                              fontSize: 22.0,
                                              letterSpacing: 1.3,
                                              height: 1.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (_) =>
                                                          CastScreen(
                                                              casts: _movie
                                                                  .casts))),
                                              child: Text(
                                                "See All",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  letterSpacing: 1.3,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CastsPageView(casts: _movie.casts),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -25,
                          right: 25,
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(55.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Container(
                                child: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Positioned(
                                    top: 13,
                                    left: 5,
                                    child: Text(
                                      _movie.voteAverage.toString(),
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Positioned(
                                  top: 23,
                                  right: 1,
                                  child: Text(
                                    "/10",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
