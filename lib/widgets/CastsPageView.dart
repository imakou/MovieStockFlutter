import 'package:flutter/material.dart';
import 'package:flutter_app/model/cast.dart';
import 'dart:math';

const PAGER_HEIGHT = 145.0;

class CastsPageView extends StatefulWidget {
  final List<Cast> casts;
  const CastsPageView({Key key, this.casts}) : super(key: key);
  @override
  _CastsPageViewState createState() => _CastsPageViewState();
}

class _CastsPageViewState extends State<CastsPageView> {
  double viewPortFraction = 0.8;
  PageController pageController;
  int currentPage = 0;
  double page = 0.0;
  List<Widget> ccasts = [];
  composeCasts() {
    List<Widget> _rowChildren = [];
    widget.casts.asMap().forEach((index, value) {
      print('index:$index');
      _rowChildren.add(
        Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: CircleBorder(
              side: BorderSide(color: Colors.grey.shade200, width: 5)),
          child: value.profilePath != null
              ? Image(
                  width: 120.0,
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w276_and_h350_face/${value.profilePath}'),
                  fit: BoxFit.cover,
                )
              : Image(
                  width: 120.0,
                  image: NetworkImage(
                      'https://i.picsum.photos/id/327/200/300.jpg'),
                  fit: BoxFit.cover,
                ),
        ),
      );

      if (_rowChildren.length == 2) {
        ccasts.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _rowChildren));
        _rowChildren = [];
      }
      // if (_composedRow.length != 0) {
      //   ccasts.add(_composedRow[0]);
      //   _composedRow = [];
      // }
    });
    setState(() {
      ccasts = ccasts;
    });
  }

  @override
  void initState() {
    pageController = PageController(
        initialPage: currentPage, viewportFraction: viewPortFraction);
    composeCasts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PAGER_HEIGHT,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            height: PAGER_HEIGHT,
            width: MediaQuery.of(context).size.width - 20,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  setState(() {
                    page = pageController.page;
                  });
                }
                return;
              },
              child: PageView.builder(
                onPageChanged: (pos) {
                  setState(() {
                    currentPage = pos;
                  });
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: ccasts.length,
                itemBuilder: (context, index) {
                  final cast = ccasts[index];
                  return Container(child: cast);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget circleOffer(String image) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    shape: CircleBorder(
                        side:
                            BorderSide(color: Colors.grey.shade200, width: 5)),
                    child: Image(
                      width: 90.0,
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w276_and_h350_face/${image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    widget.casts[currentPage].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
