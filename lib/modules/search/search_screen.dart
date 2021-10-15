import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const String id='SearchScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Search')),
    );
  }
}
