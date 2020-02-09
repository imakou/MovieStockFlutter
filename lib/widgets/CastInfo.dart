import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CastInfo extends StatefulWidget {
  final person;
  CastInfo({this.person});
  @override
  _CastInfoState createState() => _CastInfoState();
}

class _CastInfoState extends State<CastInfo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${widget.person.profilePath}'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.darken),
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35.0), bottomRight: Radius.circular(35.0)),
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        informationColumn("Name", widget.person.name),
                        informationColumn(
                            "Birthday", DateFormat('yyyy-MM-dd').format(widget.person.birthday)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Biography", style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.person.biography,
                                    style: TextStyle(letterSpacing: 0.5, wordSpacing: 2)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget informationColumn(String type, String value) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(type, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(value ?? "", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
