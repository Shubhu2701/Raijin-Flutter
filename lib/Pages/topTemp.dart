import 'package:Raijin/Pages/animeInfo.dart';
import 'package:flutter/material.dart';

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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Text(
                              top[index].title,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Row(
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
                          ),
                          top[index].episodes == null
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Text(
                                    'N/A',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                )
                              : top[index].episodes == 1
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        top[index].episodes.toString() +
                                            ' Episodes',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                    ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Row(children: [
                              Text(
                                top[index].startDate.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              if (top[index].endDate != null)
                                Text(
                                  ' - ' + top[index].endDate.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                            ]),
                          ),
                        ]),
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
