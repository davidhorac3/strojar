import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Strojař'),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          child: Text('Tolerance'),
          onPressed: () => {},
        ),
      ),
    );
  }
}
