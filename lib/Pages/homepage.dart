import 'package:Raijin/Pages/searchPage.dart';
import 'package:Raijin/Pages/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:Raijin/Pages/animeInfo.dart';
import 'package:Raijin/Pages/drawer.dart';

class Homepage extends StatefulWidget {
  Homepage();

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // ignore: avoid_init_to_null
  List topAirData = null;
  // ignore: avoid_init_to_null
  List topUpcoming = null;

  void getTopAir() async {
    var jikan = Jikan();
    var topair =
        await jikan.getTop(TopType.anime, subtype: TopSubtype.airing, page: 1);

    var topUp = await jikan.getTop(TopType.anime,
        subtype: TopSubtype.upcoming, page: 1);

    setState(() {
      topAirData = topair.toList();
      topUpcoming = topUp.toList();
    });
    print(topUp[0]);
  }

  Widget topTemplate(var animeData) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(2, 4, 1, 4),
            child: SizedBox(
              width: 130,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                elevation: 10,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AnimePage(animeData[index].malId);
                        }),
                      );
                    },
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                        ),
                        child: Stack(children: [
                          Image.network(
                            animeData[index].imageUrl,
                            fit: BoxFit.cover,
                            width: 130,
                            height: 160,
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 8, 0),
                                child: Stack(children: [
                                  Text(
                                    animeData[index].type,
                                    style: TextStyle(
                                        //color: Colors.white,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1
                                          ..color = Colors.black,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 15.0,
                                            color: Colors.black,
                                            offset: Offset(0, 0),
                                          ),
                                          Shadow(
                                            blurRadius: 15.0,
                                            color: Colors.black,
                                            offset: Offset(0, 0),
                                          ),
                                          Shadow(
                                            blurRadius: 15.0,
                                            color: Colors.black,
                                            offset: Offset(0, 0),
                                          ),
                                        ]),
                                  ),
                                  Text(animeData[index].type,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                      ))
                                ]),
                              ))
                        ]),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                          child: Text(
                            animeData[index].title,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.grade,
                                size: 14,
                                color: Colors.yellow[900],
                              ),
                              Text(
                                animeData[index].score == 0.0
                                    ? 'Score : ' + 'N/A'
                                    : 'Score : ' +
                                        animeData[index].score.toString(),
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    getTopAir();

    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[900],
      drawer: Drar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 10, 10, 6),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              ListTile(
                title: Card(
                  child: Stack(children: [
                    TextField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 60),
                            border: InputBorder.none,
                            hintText: "Search..."),
                        onSubmitted: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SearchPage(value);
                            }),
                          );
                        }),
                    IconButton(
                      onPressed: () => scaffoldKey.currentState.openDrawer(),
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                    ),
                  ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      "Top Airing",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            child: Text(
                              'View All.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          )),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  height: 220,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      color: Colors.grey[850],
                      elevation: 3,
                      child: topAirData == null
                          ? Center(
                              child: SpinKitRing(
                                color: Colors.white,
                                size: 35,
                                lineWidth: 2,
                              ),
                            )
                          : topTemplate(topAirData)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return TopPage(false);
                          }),
                        );
                      },
                      child: Card(
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                              child: Text(
                                'Top Anime',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return TopPage(true);
                          }),
                        );
                      },
                      child: Card(
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                              child: Text(
                                'Top Manga',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        "Top Upcoming :",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                              child: Text(
                                'View All.',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  height: 220,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    color: Colors.grey[850],
                    elevation: 3,
                    child: topUpcoming == null
                        ? Center(
                            child: SpinKitRing(
                              color: Colors.white,
                              size: 35,
                              lineWidth: 2,
                            ),
                          )
                        : topTemplate(topUpcoming),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
