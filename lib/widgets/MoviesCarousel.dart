import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/screens/movie_detail_screen.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/cupertino.dart';

const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;

class MoviesCarousel extends StatefulWidget {
  final List<Movie> _movies;
  const MoviesCarousel(this._movies);

  @override
  _MoviesCarouselState createState() => _MoviesCarouselState();
}

class _MoviesCarouselState extends State<MoviesCarousel> {
  double viewPortFraction = 1;
  double page = 0.0;
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
        Container(
          height: 430,
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
            CupertinoPageRoute(
                builder: (_) => MovieDetailScreen(movieID: movie.id))),
        child: Stack(
          children: <Widget>[
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.4,
                    .8,
                  ],
                  colors: [Colors.transparent, Colors.black87],
                ).createShader(Rect.fromLTRB(0, 0, 0, 500));
              },
              blendMode: BlendMode.darken,
              child: Container(
                  height: 553,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w1000_and_h563_face/${movie.posterPath}'),
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      child: Text(
                        movie.title,
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Released: ${DateFormat('yyyy-MM-dd').format(movie.releaseDate)} ",
                        style: TextStyle(
                            fontSize: 14.0,
                            letterSpacing: 1,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
