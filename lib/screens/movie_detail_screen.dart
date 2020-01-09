import 'package:flutter/material.dart';
import 'package:flutter_app/model/cast.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/widgets/CastsPageView.dart';
import 'package:intl/intl.dart';

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
                                            child: Text(
                                              "See All",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                letterSpacing: 1.3,
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CastsPageView(casts: _movie.casts),
                                    ],
                                  ),
                                  // InkWell(
                                  //   child: Container(child: Text(_movie.title)),
                                  //   onTap: () {
                                  //     print(_movie.casts[0].name);
                                  //   },
                                  // ),
                                  // Container(
                                  //   height: 100.0,
                                  //   child: FutureBuilder(
                                  //       future: fetchCasts(_movie.id),
                                  //       builder: (context, snapshot) {
                                  //         if (snapshot.connectionState ==
                                  //             ConnectionState.done) {
                                  //           final List<Cast> _cast =
                                  //               snapshot.data;
                                  //           return ListView.builder(
                                  //             scrollDirection: Axis.horizontal,
                                  //             itemCount: snapshot.data.length,
                                  //             controller: PageController(
                                  //               initialPage: 0,
                                  //               viewportFraction: 0.5,
                                  //             ),
                                  //             physics: PageScrollPhysics(),
                                  //             itemBuilder:
                                  //                 (BuildContext context,
                                  //                     int index) {
                                  //               Cast cast = _cast[index];
                                  //               return cast.profilePath != null
                                  //                   ? GestureDetector(
                                  //                       child: Container(
                                  //                           child: Column(
                                  //                         children: <Widget>[
                                  //                           CircleAvatar(
                                  //                             backgroundImage:
                                  //                                 NetworkImage(
                                  //                               'https://image.tmdb.org/t/p/w276_and_h350_face/${cast.profilePath}',
                                  //                             ),
                                  //                             minRadius: 40,
                                  //                             maxRadius: 40,
                                  //                           ),
                                  //                           SizedBox(height: 5),
                                  //                           // Text(
                                  //                           //   cast.name,
                                  //                           //   overflow:
                                  //                           //       TextOverflow.ellipsis,
                                  //                           // )
                                  //                         ],
                                  //                       )),
                                  //                     )
                                  //                   : null;
                                  //             },
                                  //           );
                                  //         } else {
                                  //           return CircularProgressIndicator();
                                  //         }
                                  //       }),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -25,
                          right: 25,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(50.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              _movie.voteAverage.toString(),
                              style: TextStyle(fontSize: 20),
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
