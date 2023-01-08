import 'package:diplom_spotify/src/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class SliverTracksList extends StatefulWidget {
  const SliverTracksList({super.key});

  @override
  State<SliverTracksList> createState() => _SliverTracksListState();
}

class _SliverTracksListState extends State<SliverTracksList> {
  bool isLoading = true;

  final List<String> tracks = [];

  void _getTracks() async {
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    tracks.addAll(List.generate(5, (index) {
      return index.toString();
    }).toList());
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getTracks();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ...tracks
            .map((e) => Container(
                  height: 65,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    bottom: 15,
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        'https://i.postimg.cc/1tf6qqQP/grozny.jpg',
                        fit: BoxFit.fill,
                        width: 65,
                        height: 65,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                height: 1.12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'data https://i.postimg.cc/1tf6qqQP/grozny.jpg',
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(context).primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        child: IconButton(
                          splashRadius: 25,
                          iconSize: 27.5,
                          padding: const EdgeInsets.all(18),
                          icon: Icon(
                            Icons.play_circle_outline_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
        Center(
          child: isLoading
              ? const CustomCircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => _getTracks(),
                  child: const SizedBox(
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text(
                        'Загрузить ещё',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.12,
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 60),
      ]),
    );
  }
}
