import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/widgets/MoviesCarousel.dart';
import 'package:flutter_app/widgets/PopularMoviesCarousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _nowPlayingMovies = List<Movie>();
  List<Movie> _popularMovies = List<Movie>();
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
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.grey[700],
      //   selectedItemColor: Colors.white,
      //   selectedFontSize: 12,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.movie,
      //         ),
      //         title: Text(
      //           'Home',
      //         )),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.subject,
      //         ),
      //         title: Text(
      //           'Explore',
      //         )),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.search,
      //         ),
      //         title: Text(
      //           'Search',
      //         )),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.account_box,
      //         ),
      //         title: Text(
      //           'Account',
      //         )),
      //   ],
      //   currentIndex: _currentIndex,
      //   onTap: (int index) {
      //     // setState(() {
      //     //   _currentIndex = index;
      //     // });
      //   },
      // )
    );
  }
}
