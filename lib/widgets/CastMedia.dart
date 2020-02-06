import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/person.dart';
import 'package:flutter_app/screens/movie_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CastMedia extends StatefulWidget {
  final List<PersonPoster> castMedia;
  CastMedia({this.castMedia});

  @override
  _CastMediaState createState() => _CastMediaState();
}

class _CastMediaState extends State<CastMedia> {
  @override
  Widget build(BuildContext context) {
    Set<int> ids = {};
    widget.castMedia.forEach((e) => ids.add(e.media.id));
    List _castMeida = widget.castMedia.where((e) {
      if (ids.contains(e.media.id)) {
        ids.remove(e.media.id);
        return true;
      }
      return false;
    }).toList();
    return Container(
      color: Colors.grey[800],
      child: SafeArea(
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            children: _castMeida.map((poster) {
              final media = poster.media;
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (_) => MovieDetailScreen(movieID: media.id))),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 115,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500_and_h282_face/${poster.filePath}'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0),
                                  BlendMode.darken),
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0)),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  media.title ?? "N/A",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[300]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: SmoothStarRating(
                                      allowHalfRating: false,
                                      starCount: 5,
                                      rating: media.voteAverage / 2,
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
              );
            }).toList()),
      ),
    );
  }
}
