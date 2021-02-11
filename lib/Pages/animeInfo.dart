import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimePage extends StatefulWidget {
  final int animeId;
  AnimePage(this.animeId);
  @override
  _AnimePageState createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  var animeInfo;
  String listStats;

  List<String> listOptions = [
    'Plan to Watch',
    'Watching',
    'Completed',
    'On Hold',
    'Dropped'
  ];
  // Widget relatedTemp(var anime){
  //   ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 15,
  //       itemBuilder: (context, index) {
  //         return Padding(
  //           padding: const EdgeInsets.fromLTRB(2, 4, 1, 4),
  //           child: SizedBox(
  //             width: 130,
  //             child: Card(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(6.0))),
  //               elevation: 10,
  //               child: InkWell(
  //                   onTap: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(builder: (context) {
  //                         return AnimePage(anime[index].malId);
  //                       }),
  //                     );
  //                   },
  //                   child: Column(children: [
  //                     ClipRRect(
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(6.0),
  //                         topRight: Radius.circular(6.0),
  //                       ),
  //                       child: Stack(children: [
  //                         Image.network(
  //                           animeData[index].imageUrl,
  //                           fit: BoxFit.cover,
  //                           width: 130,
  //                           height: 160,
  //                         ),
  //                         Align(
  //                             alignment: Alignment.topRight,
  //                             child: Padding(
  //                               padding: const EdgeInsets.fromLTRB(0, 4, 8, 0),
  //                               child: Stack(children: [
  //                                 Text(
  //                                   animeData[index].type,
  //                                   style: TextStyle(
  //                                       //color: Colors.white,
  //                                       fontFamily: 'Nunito',
  //                                       fontWeight: FontWeight.bold,
  //                                       foreground: Paint()
  //                                         ..style = PaintingStyle.stroke
  //                                         ..strokeWidth = 1
  //                                         ..color = Colors.black,
  //                                       shadows: [
  //                                         Shadow(
  //                                           blurRadius: 15.0,
  //                                           color: Colors.black,
  //                                           offset: Offset(0, 0),
  //                                         ),
  //                                         Shadow(
  //                                           blurRadius: 15.0,
  //                                           color: Colors.black,
  //                                           offset: Offset(0, 0),
  //                                         ),
  //                                         Shadow(
  //                                           blurRadius: 15.0,
  //                                           color: Colors.black,
  //                                           offset: Offset(0, 0),
  //                                         ),
  //                                       ]),
  //                                 ),
  //                                 Text(animeData[index].type,
  //                                     style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontFamily: 'Nunito',
  //                                       fontWeight: FontWeight.bold,
  //                                     ))
  //                               ]),
  //                             ))
  //                       ]),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.topLeft,
  //                       child: Padding(
  //                         padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
  //                         child: Text(
  //                           animeData[index].title,
  //                           style: TextStyle(
  //                               fontFamily: 'Nunito',
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.bold),
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.topLeft,
  //                       child: Padding(
  //                         padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           children: [
  //                             Icon(
  //                               Icons.grade,
  //                               size: 14,
  //                               color: Colors.yellow[900],
  //                             ),
  //                             Text(
  //                               anime.[index].score == 0.0
  //                                   ? 'Score : ' + 'N/A'
  //                                   : 'Score : ' +
  //                                       animeData[index].score.toString(),
  //                               style: TextStyle(
  //                                   fontFamily: 'Nunito',
  //                                   fontSize: 11,
  //                                   fontWeight: FontWeight.w500),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ])),
  //             ),
  //           ),
  //         );
  //       });
  // }
  Widget namesTemp(names) {
    return Text(
      '' + names.name.toString() + ' ',
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Nunito',
        fontSize: 13,
      ),
      overflow: TextOverflow.visible,
    );
  }

  Widget genreTemp(genre) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Text(
              genre.name,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 15,
              ),
            ),
          )),
    );
  }

  var relate;
  void getAnimeInfo() async {
    var jikan = Jikan();
    var anime = await jikan.getAnimeInfo(widget.animeId);

    setState(() {
      animeInfo = anime;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getAnimeInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: animeInfo == null
            ? AppBar(
                backgroundColor: Colors.black,
                toolbarHeight: 50,
                centerTitle: true,
                title: Text(
                  ' ',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Nunito', fontSize: 17),
                ))
            : AppBar(
                backgroundColor: Colors.black,
                toolbarHeight: 50,
                centerTitle: true,
                title: Text(
                  animeInfo.title,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Nunito', fontSize: 17),
                )),
        body: animeInfo == null
            ? Center(
                child: SpinKitRing(
                  color: Colors.white,
                  size: 35,
                  lineWidth: 2,
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  InkWell(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                      child: Image.network(animeInfo.imageUrl,
                                          height: 200,
                                          width: 140,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Padding(
                                    //shadow
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 0, 0),
                                    child: Text(
                                      animeInfo.type,
                                      style: TextStyle(
                                          //color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 1.5
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
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 0, 0),
                                    child: Text(animeInfo.type,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                  ),
                                  Positioned(
                                    right: 10,
                                    bottom: 6,
                                    child: Text(
                                      '#' + animeInfo.rank.toString(),
                                      style: TextStyle(
                                          //color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 1.5
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
                                  Positioned(
                                    right: 10,
                                    bottom: 6,
                                    child: Text('#' + animeInfo.rank.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                  )
                                ]),
                                Expanded(
                                  //Main info
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Text(
                                            animeInfo.title,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16.5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(children: [
                                          Icon(
                                            Icons.grade,
                                            size: 20,
                                            color: Colors.yellow[900],
                                          ),
                                          Text(
                                            animeInfo.score == null
                                                ? 'N/A'
                                                : ' ' +
                                                    animeInfo.score.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),
                                        Row(children: [
                                          Icon(
                                            Icons.trending_up_rounded,
                                            size: 20,
                                            color: Colors.red[900],
                                          ),
                                          Text(
                                            animeInfo.popularity == null
                                                ? 'N/A'
                                                : ' ' +
                                                    animeInfo.popularity
                                                        .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),
                                        Text(
                                          animeInfo.episodes == null
                                              ? 'Episodes : ' + 'N/A'
                                              : 'Episodes : ' +
                                                  animeInfo.episodes.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Status : ' + animeInfo.status,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Duration : ' + animeInfo.duration,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 6, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              DropdownButton(
                                                hint: Text(
                                                  'Add to List',
                                                  style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                                value: listStats = null,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    listStats = newValue;
                                                  });
                                                },
                                                items: listOptions.map((stat) {
                                                  return DropdownMenuItem(
                                                    child: new Text(
                                                      stat,
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    value: listStats,
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      SingleChildScrollView(
                        //Genre
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: animeInfo.genres
                                .map<Widget>((genre) => genreTemp(genre))
                                .toList()),
                      ),
                      Padding(
                        //Title Synonyms
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                animeInfo.titleEnglish != null
                                    ? Row(children: [
                                        Text(
                                          'English Title : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Nunito',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          animeInfo.titleEnglish,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ])
                                    : Row(),
                                animeInfo.titleJapanese != null
                                    ? Row(children: [
                                        Text(
                                          'Japanese Title : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Nunito',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          animeInfo.titleJapanese,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ])
                                    : null,
                                animeInfo.titleSynonyms != null
                                    ? Text(
                                        'Title Synonyms : ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : null,
                                animeInfo.titleSynonyms != null
                                    ? Text(
                                        animeInfo.titleSynonyms.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                          fontSize: 15,
                                        ),
                                      )
                                    : null,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        //Statistics
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.rate_review,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      'Scored By : ' +
                                          animeInfo.scoredBy.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.group_outlined,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'Members : ' +
                                          animeInfo.members.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.pink,
                                    ),
                                    Text(
                                      'Favorites : ' +
                                          animeInfo.favorites.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        //More Info
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: Text(
                                    'More Information : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(children: [
                                  Text(
                                    'Source : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    animeInfo.source,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 13,
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  Text(
                                    'Aired : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    animeInfo.aired.string,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 13,
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  Text(
                                    'Rating : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    animeInfo.rating,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 13,
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  Text(
                                    'Premiered : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  animeInfo.premiered == null
                                      ? Text(
                                          'N/A',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontSize: 13,
                                          ),
                                        )
                                      : Text(
                                          animeInfo.premiered,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontSize: 13,
                                          ),
                                        ),
                                ]),
                                Row(children: [
                                  Text(
                                    'Broadcast : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  animeInfo.broadcast == null
                                      ? Text(
                                          'N/A',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontSize: 13,
                                          ),
                                        )
                                      : Text(
                                          animeInfo.broadcast + '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontSize: 13,
                                          ),
                                        ),
                                ]),
                                Text(
                                  'Studios : ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                for (var name in animeInfo.studios)
                                  (namesTemp(name)),
                                Text(
                                  'Producers : ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                for (var name in animeInfo.producers)
                                  (namesTemp(name)),
                                Text(
                                  'Licensors : ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                for (var name in animeInfo.licensors)
                                  (namesTemp(name)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
