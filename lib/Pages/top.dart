import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:Raijin/Pages/topTemp.dart';

class TopPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Top Anime'),
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
