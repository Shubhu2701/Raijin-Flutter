import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:Mal/Pages/animeInfo.dart';

class TopPage extends StatefulWidget {
  final bool manga;
  TopPage(this.manga);
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  // ignore: avoid_init_to_null
  var topScore = null;
  // ignore: avoid_init_to_null
  var topPopu = null;

  void getTopData(int i) async {
    var jikan = Jikan();
    var topDataScore = await jikan.getTop(TopType.anime, page: i);
    var topDataPopu = await jikan.getTop(TopType.anime,
        subtype: TopSubtype.bypopularity, page: i);

    setState(() {
      topScore = topDataScore.toList();
      topPopu = topDataPopu.toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getTopData(1);
    super.initState();
  }

  Widget toptemp(var top) {
    return ListView.builder(
        itemCount: top.length,
        itemBuilder: (context, index) {
          return Stack(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return AnimePage(top[index].malId);
                      }),
                    );
                  },
                  child: Row(children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        child: Image.network(top[index].imageUrl,
                            width: 100, height: 140, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 4, 0, 0),
                        child: Text(
                          top[index].type,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 4, 0, 0),
                        child: Text(top[index].type,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ]),
                    Flexible(
                      child: ListTile(
                        title: Text(
                          top[index].title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.grade,
                                    size: 18,
                                    color: Colors.yellow[900],
                                  ),
                                  Text(
                                    top[index].score.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                    ),
                                  )
                                ],
                              ),
                              top[index].volumes == 1
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Text(
                                        top[index].episodes.toString() +
                                            ' Episode',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                      child: Text(
                                        top[index].episodes.toString() +
                                            ' Episodes',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                    ),
                            ]),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: 15,
              child: Stack(children: [
                Text(
                  '#' + top[index].rank.toString(),
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2.5
                        ..color = Colors.black,
                      shadows: [
                        Shadow(
                          blurRadius: 3.0,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ]),
                ),
                Text(
                  '#' + top[index].rank.toString(),
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ]),
            )
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: widget.manga == true ? Text('Top Manga') : Text('Top Anime'),
          backgroundColor: Colors.black,
          toolbarHeight: 60,
          bottom: TabBar(
            tabs: [Text('Score'), Text('Popularity')],
          ),
        ),
        body: TabBarView(children: [
          topScore == null
              ? Center(
                  child: SpinKitRing(
                    color: Colors.white,
                    size: 35,
                    lineWidth: 2,
                  ),
                )
              : toptemp(topScore),
          topPopu == null
              ? Center(
                  child: SpinKitRing(
                    color: Colors.white,
                    size: 35,
                    lineWidth: 2,
                  ),
                )
              : toptemp(topPopu)
        ]),
      ),
    );
  }
}
