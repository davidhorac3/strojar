import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TolerancesPage extends StatefulWidget {
  @override
  _TolerancesPageState createState() => _TolerancesPageState();
}

class _TolerancesPageState extends State<TolerancesPage> {
  Future data =
      rootBundle.loadString('assets/data/tolerances.json').then((cont) {
    return json.decode(cont);
  });

  int sizeIndex = 0;
  int typeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tolerance'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Text('');
          }

          final parsed = snapshot.data;
          String size = parsed['ranges'][sizeIndex];
          bool hole = parsed['data'][typeIndex]['hole'];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: parsed['ranges']
                        .asMap()
                        .map<dynamic, Widget>((index, range) {
                          return MapEntry(
                            index,
                            Container(
                              height: 50,
                              child: FlatButton(
                                textColor: sizeIndex == index
                                    ? Colors.yellowAccent
                                    : Colors.white,
                                onPressed: () {
                                  setState(() {
                                    sizeIndex = index;
                                  });
                                },
                                child: Text(range),
                              ),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Ø$size'),
                        Column(
                          children: <Widget>[
                            Text(parsed['data'][typeIndex]['limits'][sizeIndex]
                                          [1]
                                      .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              parsed['data'][typeIndex]['limits'][sizeIndex][0]
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      hole
                          ? 'assets/images/hole.png'
                          : 'assets/images/shaft.png',
                      height: 100,
                      width: 100,
                    ),
                    Text(parsed['data'][typeIndex]['label']),
                  ],
                ),
              ),
              Container(
                width: 100,
                child: ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(5),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: FlatButton(
                          textColor: typeIndex == index
                              ? Colors.yellowAccent
                              : Colors.white,
                          onPressed: () {
                            setState(() {
                              typeIndex = index;
                            });
                          },
                          child: Text(parsed['data'][index]['label']),
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
