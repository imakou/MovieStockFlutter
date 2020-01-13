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
    pageController = PageController(
        initialPage: currentPage, viewportFraction: viewPortFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Popular Movies',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
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
                    final scale = max(SCALE_FRACTION,
                        (FULL_SCALE - (index - page).abs()) + viewPortFraction);
                    return posterOffer(movie, scale);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget posterOffer(Movie movie, double scale) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MovieDetailScreen(movieID: movie.id))),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    color: Colors.grey[600],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500_and_h282_face/${movie.posterPath}'),
                            fit: BoxFit.cover,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${movie.title} (${DateFormat('yyyy').format(movie.releaseDate)})",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[300]),
                                  ),
                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      starCount: 5,
                                      rating: movie.voteAverage / 2,
                                      size: 18.0,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      color: Colors.yellow,
                                      borderColor: Colors.yellow,
                                      spacing: 0.0),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
