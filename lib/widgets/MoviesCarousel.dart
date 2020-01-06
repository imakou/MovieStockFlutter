import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/screens/movie_detail_screen.dart';

class MoviesCarousel extends StatelessWidget {
  final List<Movie> _movies;
  const MoviesCarousel(this._movies, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              top: 15.0,
              left: 10.0,
            ),
            child: Text(
              'What are the popular movies?',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _movies.length,
            itemBuilder: (BuildContext context, int index) {
              Movie movie = _movies[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movieID: movie.id))),
                child: Container(
                    child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                height: 180.0,
                                width: 180.0,
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500_and_h282_face/${movie.posterPath}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              child: Container(
                                height: 45,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              child: Container(
                                width: 180,
                                child: Text(
                                  movie.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            // Positioned(
                            //   left: 10.0,
                            //   bottom: 10.0,
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       color: Colors.black54,
                            //       borderRadius: BorderRadius.circular(20.0),
                            //     ),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: <Widget>[
                            //         Text(
                            //           movie.title,
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 18.0,
                            //             fontWeight: FontWeight.w600,
                            //             letterSpacing: 1.2,
                            //           ),
                            //         ),
                            //         Row(
                            //           children: <Widget>[
                            //             SizedBox(width: 5.0),
                            //             Text(
                            //               movie.popularity.toString(),
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              );
            },
          ),
        ),
      ],
    );
  }
}
