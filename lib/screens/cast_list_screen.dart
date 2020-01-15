import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/cast.dart';

import 'cast_detail_screen.dart';

class CastScreen extends StatefulWidget {
  final List<Cast> casts;
  CastScreen({this.casts});

  @override
  _CastScreenState createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: BackButton(color: Colors.grey[700]),
        title: Text(
          'Casts',
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Wrap(
              children: <Widget>[
                ...widget.casts.map((cast) => castOffer(cast)).toList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget castOffer(Cast cast) {
    print(cast.character);
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (_) => CastDetail(personID: cast.id))),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: <Widget>[
                  cast.profilePath != null
                      ? CircleAvatar(
                          maxRadius: 50,
                          minRadius: 50,
                          backgroundImage: NetworkImage(
                              'https://image.tmdb.org/t/p/w276_and_h350_face/${cast.profilePath}'),
                        )
                      : Icon(
                          Icons.person,
                          color: Colors.grey[400],
                          size: 100.0,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    cast.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  cast.character.trim() != ""
                      ? Text(
                          "(${cast.character})",
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(""),
                ],
              ),
            ),
          )),
    );
  }
}
