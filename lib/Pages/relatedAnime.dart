import 'package:Raijin/Pages/animeInfo.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

// ignore: must_be_immutable
class Relate extends StatefulWidget {
  var names;
  Relate(this.names);
  @override
  _RelateState createState() => _RelateState();
}

class _RelateState extends State<Relate> {
  var relatedAnime;
  void relateInfo() async {
    var jikan = Jikan();
    var anime = await jikan.getAnimeInfo(widget.names.malId);
    setState(() {
      relatedAnime = anime;
    });
    print(relatedAnime);
  }

  @override
  void initState() {
    relateInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: OutlineButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Text(
          widget.names.name,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Nunito',
            fontSize: 13,
          ),
          overflow: TextOverflow.visible,
        ),
        onPressed: () {
          setState(() {
            showModalBottomSheet<void>(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                context: context,
                builder: (BuildContext context) {
                  return Flexible(
                    child: Container(
                        color: Colors.black,
                        height: 208,
                        child: Card(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: ClipRRect(
                                    child: Image.network(relatedAnime.imageUrl,
                                        height: 200,
                                        width: 140,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Expanded(
                                  //Main info
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Text(
                                            relatedAnime.title,
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
                                            relatedAnime.score == null
                                                ? 'N/A'
                                                : ' ' +
                                                    relatedAnime.score
                                                        .toString(),
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
                                            relatedAnime.popularity == null
                                                ? 'N/A'
                                                : ' ' +
                                                    relatedAnime.popularity
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
                                          relatedAnime.episodes == null
                                              ? 'Episodes : ' + 'N/A'
                                              : 'Episodes : ' +
                                                  relatedAnime.episodes
                                                      .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Status : ' + relatedAnime.status,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Duration : ' + relatedAnime.duration,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 4, right: 4),
                                          child: OutlineButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return AnimePage(
                                                      relatedAnime.malId);
                                                }),
                                              );
                                            },
                                            child: Text('More Info'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        )),
                  );
                });
          });
        },
      ),
    );
  }
}
