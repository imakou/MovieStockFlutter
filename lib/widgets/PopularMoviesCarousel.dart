import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/screens/movie_detail_screen.dart';
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
        Text(
          'Popular Movies',
          style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Container(
          height: 355,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      setState(() {
                        page = pageController.page;
                      });
                    }
                  },
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
                          SCALE_FRACTION,
                          (FULL_SCALE - (index - page).abs()) +
                              viewPortFraction);
                      return posterOffer(movie, scale);
                    },
                  ),
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
                    color: Colors.white,
                    width: 355,
                    height: 150,
                    child: Card(
                      child: Image(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500_and_h282_face/${movie.posterPath}'),
                        fit: BoxFit.cover,
                      ),
                    )),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Center(
                              child: Text(
                            movie.voteAverage.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
