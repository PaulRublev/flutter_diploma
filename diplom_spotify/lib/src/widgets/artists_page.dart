import 'package:flutter/material.dart';

class ArtistsPage extends StatelessWidget {
  final String title;

  const ArtistsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ArtistsGridView(
        storageKeyName: title,
      ),
    );
  }
}

class ArtistsGridView extends StatefulWidget {
  const ArtistsGridView({super.key, required this.storageKeyName});

  final String storageKeyName;

  @override
  State<ArtistsGridView> createState() => _ArtistsGridViewState();
}

class _ArtistsGridViewState extends State<ArtistsGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: PageStorageKey(widget.storageKeyName),
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 15,
        bottom: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1.3,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          clipBehavior: Clip.antiAlias,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  'https://i.postimg.cc/1tf6qqQP/grozny.jpg',
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 45,
                child: Center(
                  child: Text(index.toString()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
