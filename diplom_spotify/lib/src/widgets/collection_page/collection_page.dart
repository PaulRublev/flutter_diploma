import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  final String title;

  const CollectionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 83,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(),
    );
  }
}
