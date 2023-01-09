import 'package:diplom_spotify/src/widgets/utility_widgets/bottom_sheet_player.dart';
import 'package:diplom_spotify/src/widgets/utility_widgets/custom_circular_progress_indicator.dart';
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
    await Future.delayed(const Duration(seconds: 1));
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
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'data https://i.postimg.cc/1tf6qqQP/grozny.jpg',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.overline,
                            ),
                          ],
                        ),
                      ),
                      Material(
                        child: IconButton(
                          splashRadius: 25,
                          padding: const EdgeInsets.all(18),
                          icon: const Icon(Icons.play_circle_outline_rounded),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: const Color(0x00000000),
                              builder: (context) => const BottomSheetPlayer(),
                            );
                          },
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
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text(
                        'Загрузить ещё',
                        style: Theme.of(context).textTheme.subtitle2,
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
