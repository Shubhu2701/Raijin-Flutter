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
  // ignore: avoid_init_to_null
  List searchAnimeData = null;
  // ignore: avoid_init_to_null
  List seachMangaData = null;
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
      seachMangaData = search.toList();
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
                  ]),
                  Flexible(
                    child: ListTile(
                      title: Text(
                        animeData[index].title,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 6, 0, 6),
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
                                ? Text(
                                    'Not Rated',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                    ),
                                  )
                                : Text(
                                    animeData[index].rated,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                            animeData[index].startDate == null
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 6, 0, 0),
                                    child: Text(
                                      'Not Yet Aired',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 6, 0, 0),
                                    child: Text(
                                      animeData[index].startDate[0] +
                                          animeData[index].startDate[1] +
                                          animeData[index].startDate[2] +
                                          animeData[index].startDate[3],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  )
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
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
      ),
      body: SafeArea(
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
    );
  }
}
