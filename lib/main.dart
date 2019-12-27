import 'package:flutter/material.dart';
import 'package:strojar/pages/home.dart';
import 'package:strojar/pages/tolerances.dart';

void main() => runApp(MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(),
      ),
      routes: {
        '/': (context) => Home(),
        '/tolerance': (context) => TolerancesPage(),
      },
      initialRoute: '/tolerance',
    ));
