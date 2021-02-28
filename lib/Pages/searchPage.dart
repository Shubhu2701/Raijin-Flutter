import 'package:Raijin/Pages/mangaInfo.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:Raijin/Pages/animeInfo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchPage extends StatefulWidget {
  final String searchVar;
  SearchPage(this.searchVar);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var month = {
    01: 'Jan',
    02: 'Feb',
    03: 'Mar',
    04: 'Apr',
    05: 'May',
    06: 'Jun',
    07: 'Jul',
    08: 'Aug',
    09: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };
  // ignore: avoid_init_to_null
  List searchAnimeData = null;
  // ignore: avoid_init_to_null
  List searchMangaData = null;
  bool nsfw = true;

  void getSearchAnime(
    var searchString,
  ) async {
    var jikan = Jikan();
    var search = await jikan.search(
      searchString,
      SearchType.anime,
    );
    setState(() {
      searchAnimeData = search.toList();
    });
    print(search[0]);
  }

  void getSearchManga(
    String searchString,
  ) async {
    var jikan = Jikan();
    var search = await jikan.search(searchString, SearchType.manga, page: 1);
    setState(() {
      searchMangaData = search.toList();
    });
    print(search[0]);
  }

  Widget searchResultTemplate(var animeData) {
    return ListView.builder(
        itemCount: animeData.length,
        itemBuilder: (context, index) {
          if (nsfw == false) {
            if (animeData[index].rated == 'Rx') {
              index++;
            }
          }

          return Padding(
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
                      return AnimePage(animeData[index].malId);
                    }),
                  );
                },
                child: Row(children: [
                  Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      child: Image.network(animeData[index].imageUrl,
                          width: 100, height: 140, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 4, 0, 0),
                      child: Text(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 4, 0, 0),
                      child: Text(animeData[index].type,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    if (animeData[index].airing == true)
                      Positioned(
                        bottom: 2,
                        child: Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            child: Text('Airing',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ),
                        ),
                      ),
                  ]),
                  Flexible(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 6),
                        child: Text(
                          animeData[index].title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
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
                                  animeData[index].score.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Nunito',
                                  ),
                                )
                              ],
                            ),
                            animeData[index].episodes == 1
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      animeData[index].episodes.toString() +
                                          ' Episode',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      animeData[index].episodes.toString() +
                                          ' Episodes',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ),
                            animeData[index].rated == null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Not Rated',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      animeData[index].rated,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ),
                            animeData[index].startDate == null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Not Yet Aired',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  )
                                : Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        animeData[index].startDate[5] +
                                            animeData[index].startDate[6] +
                                            ' / ' +
                                            animeData[index].startDate[0] +
                                            animeData[index].startDate[1] +
                                            animeData[index].startDate[2] +
                                            animeData[index].startDate[3],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                    ),
                                    if (animeData[index].endDate != null)
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Icon(
                                            Icons.remove,
                                            size: 15,
                                          )),
                                    if (animeData[index].endDate != null)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          animeData[index].endDate[5] +
                                              animeData[index].endDate[6] +
                                              ' / ' +
                                              animeData[index].endDate[0] +
                                              animeData[index].endDate[1] +
                                              animeData[index].endDate[2] +
                                              animeData[index].endDate[3],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ),
                                  ])
                          ]),
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }

  Widget searchResultMangaTemplate(var animeData) {
    return ListView.builder(
        itemCount: animeData.length,
        itemBuilder: (context, index) {
          if (nsfw == false) {
            if (animeData[index].rated == 'Rx') {
              index++;
            }
          }

          return Padding(
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
                      return MangaPage(animeData[index].malId);
                    }),
                  );
                },
                child: Row(children: [
                  Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      child: Image.network(animeData[index].imageUrl,
                          width: 100, height: 140, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 4, 0, 0),
                      child: Text(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 4, 0, 0),
                      child: Text(animeData[index].type,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    if (animeData[index].publishing == true)
                      Positioned(
                        bottom: 2,
                        child: Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            child: Text('Publishing',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ),
                        ),
                      ),
                  ]),
                  Flexible(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 6),
                        child: Text(
                          animeData[index].title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
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
                                  animeData[index].score.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Nunito',
                                  ),
                                )
                              ],
                            ),
                            animeData[index].volumes == null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Volumes : N/A',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Volumes : ' +
                                          animeData[index].volumes.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ),
                            animeData[index].chapters == null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Chapters : N/A',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Chapters : ' +
                                          animeData[index].chapters.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ),
                            animeData[index].startDate == null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Not Yet Aired',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  )
                                : Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        animeData[index].startDate[5] +
                                            animeData[index].startDate[6] +
                                            ' / ' +
                                            animeData[index].startDate[0] +
                                            animeData[index].startDate[1] +
                                            animeData[index].startDate[2] +
                                            animeData[index].startDate[3],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                    ),
                                    if (animeData[index].endDate != null)
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Icon(
                                            Icons.remove,
                                            size: 15,
                                          )),
                                    if (animeData[index].endDate != null)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          animeData[index].endDate[5] +
                                              animeData[index].endDate[6] +
                                              ' / ' +
                                              animeData[index].endDate[0] +
                                              animeData[index].endDate[1] +
                                              animeData[index].endDate[2] +
                                              animeData[index].endDate[3],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ),
                                  ])
                          ]),
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSearchAnime(widget.searchVar);
    getSearchManga(widget.searchVar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SearchPage(value);
                      }),
                    );
                  }),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ]),
          ),
          bottom: TabBar(
            tabs: [Text('Anime'), Text('Manga')],
          ),
        ),
        body: TabBarView(children: [
          SafeArea(
            child: searchAnimeData == null
                ? Center(
                    child: SpinKitRing(
                      color: Colors.white,
                      size: 35,
                      lineWidth: 2,
                    ),
                  )
                : searchResultTemplate(searchAnimeData),
          ),
          SafeArea(
            child: searchAnimeData == null
                ? Center(
                    child: SpinKitRing(
                      color: Colors.white,
                      size: 35,
                      lineWidth: 2,
                    ),
                  )
                : searchResultMangaTemplate(searchMangaData),
          ),
        ]),
      ),
    );
  }
}
