import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/screens/movie_detail_screen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';
import 'dart:math';

const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;

class PopularMoviesCarousel extends StatefulWidget {
  final List<Movie> _movies;
  const PopularMoviesCarousel(this._movies);

  @override
  _PopularMoviesCarouselState createState() => _PopularMoviesCarouselState();
}

class _PopularMoviesCarouselState extends State<PopularMoviesCarousel> {
  double viewPortFraction = 0.8;
  double page = 2.0;
  int currentPage = 0;
  PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: currentPage, viewportFraction: viewPortFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Popular Movies',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Container(
            height: 355,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: new PageView.builder(
                    onPageChanged: (pos) {
                      setState(() {
                        currentPage = pos;
                      });
                    },
                    physics: BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: widget._movies.length,
                    itemBuilder: (context, index) {
                      Movie movie = widget._movies[index];
                      final scale = max(
                          SCALE_FRACTION, (FULL_SCALE - (index - page).abs()) + viewPortFraction);
                      return posterOffer(movie, scale);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget posterOffer(Movie movie, double scale) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => MovieDetailScreen(movieID: movie.id))),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500_and_h282_face/${movie.posterPath}'),
                              fit: BoxFit.cover,
                              colorFilter:
                                  ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.darken),
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  movie.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[300]),
                                ),
                                Text(
                                  "${DateFormat('yyyy').format(movie.releaseDate)}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14.0, color: Colors.grey[300]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: SmoothStarRating(
                                      allowHalfRating: false,
                                      starCount: 5,
                                      rating: movie.voteAverage / 2,
                                      size: 18.0,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      color: Colors.yellow,
                                      borderColor: Colors.yellow,
                                      spacing: 0.0),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
