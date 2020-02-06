import 'package:flutter/material.dart';
import 'package:flutter_app/model/person.dart';
import 'package:flutter_app/widgets/CastInfo.dart';
import 'package:flutter_app/widgets/CastMedia.dart';

class CastDetail extends StatefulWidget {
  final int personID;
  CastDetail({this.personID});

  @override
  _CastDetailState createState() => _CastDetailState();
}

class _CastDetailState extends State<CastDetail> {
  Person _person;
  int _currentIndex = 0;
  List<Widget> _castScreens;
  @override
  void initState() {
    // TODO: implement initState
    fetchPerson(widget.personID).then((person) => {
          setState(() => {_person = person}),
          _castScreens = [
            CastInfo(person: person),
            CastMedia(castMedia: person.poster)
          ],
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_person is Person)
          ? _castScreens[_currentIndex]
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[700],
        selectedItemColor: Colors.white,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.perm_contact_calendar,
              ),
              title: Text(
                'Home',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.perm_contact_calendar,
              ),
              title: Text(
                'Biography',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_filter,
              ),
              title: Text(
                'Works',
              )),
        ],
        currentIndex: _currentIndex + 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false);
          } else {
            setState(() {
              _currentIndex = index - 1;
            });
          }
        },
      ),
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
