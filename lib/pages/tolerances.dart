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
          String type = parsed['data'][typeIndex]['label'];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: ListView.builder(
                    itemCount: parsed['ranges'].length,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(5),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: FlatButton(
                          textColor: sizeIndex == index ? Colors.yellowAccent : Colors.white,
                          onPressed: () {
                            setState(() {
                              sizeIndex = index;
                            });
                          },
                          child: Text(parsed['ranges'][index]),
                        ),
                      );
                    }),
              ),
              Column(
                children: <Widget>[
                  Text(''),
                  Text('Ø$size'),
                  Text(''),
                  Text('$type'),
                  Text(''),
                  Text(parsed['data'][typeIndex]['limits'][sizeIndex][1]
                      .toString()),
                  Text(''),
                  Text(parsed['data'][typeIndex]['limits'][sizeIndex][0]
                      .toString())
                ],
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
                          textColor: typeIndex == index ? Colors.yellowAccent : Colors.white,
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
