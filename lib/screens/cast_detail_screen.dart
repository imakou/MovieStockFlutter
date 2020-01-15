import 'package:flutter/material.dart';
import 'package:flutter_app/model/person.dart';
import 'package:intl/intl.dart';

class CastDetail extends StatefulWidget {
  int personID;
  CastDetail({this.personID});

  @override
  _CastDetailState createState() => _CastDetailState();
}

class _CastDetailState extends State<CastDetail> {
  Person _person;
  @override
  void initState() {
    // TODO: implement initState
    fetchPerson(widget.personID).then((person) => {
          setState(() => {_person = person})
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_person is Person)
            ? Stack(
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
                                    'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${_person.profilePath}'),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0),
                                    BlendMode.darken),
                              ),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(35.0),
                                  bottomRight: Radius.circular(35.0)),
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
                                  informationColumn("Name", _person.name),
                                  informationColumn(
                                      "Birthday",
                                      DateFormat('yyyy-MM-dd')
                                          .format(_person.birthday)),
                                  informationColumn(
                                      "Place of Birth", _person.placeOfBirth),
                                  informationColumn(
                                      "Known For", _person.knownForDepartment),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15.0, 10, 15, 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Biography"),
                                          Text(_person.biography),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 35.0),
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
                      ],
                    ),
                  ),
                ],
              )
            : CircularProgressIndicator());
  }

  Widget informationColumn(String type, String value) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(type),
            Text(value ?? ""),
          ],
        ),
      ),
    );
  }
}
