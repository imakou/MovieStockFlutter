import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/screens/movie_detail_screen.dart';
import 'dart:math';

const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;
const PAGER_HEIGHT = 200.0;

class MoviesCarousel extends StatefulWidget {
  final List<Movie> _movies;
  const MoviesCarousel(this._movies);

  @override
  _MoviesCarouselState createState() => _MoviesCarouselState();
}

class _MoviesCarouselState extends State<MoviesCarousel> {
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
    print(MediaQuery.of(context).size.width);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Now Playing Movies',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 470,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 20,
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
          padding: const EdgeInsets.all(10.0),
          child: Container(
              child: Image(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w300_and_h450_bestv2/${movie.posterPath}'),
            fit: BoxFit.cover,
          )
              // child: Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(20.0),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black26,
              //         offset: Offset(0.0, 2.0),
              //         blurRadius: 6.0,
              //       ),
              //     ],
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(20.0),
              //     child: Image(
              //       width: MediaQuery.of(context).size.width - 20,
              //       image: NetworkImage(
              //           'https://image.tmdb.org/t/p/w300_and_h450_bestv2/${movie.posterPath}'),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              ),
        ));
  }
}
