import 'package:diplom_spotify/src/utils/track.dart';
import 'package:diplom_spotify/src/widgets/utility_widgets/bottom_sheet_player.dart';
import 'package:diplom_spotify/src/widgets/utility_widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;

class SliverTracksList extends StatefulWidget {
  final String artistId;

  const SliverTracksList({super.key, required this.artistId});

  @override
  State<SliverTracksList> createState() => _SliverTracksListState();
}

class _SliverTracksListState extends State<SliverTracksList> {
  static const loadButtonText = 'Загрузить ещё';

  bool isLoading = true;
  int _offset = 0;
  final List<Track> tracks = [];

  Future<bool> _getTracksTop() async {
    isLoading = true;
    setState(() {});
    final offset = _offset == 0 ? '' : '&offset=$_offset';
    _offset += 5;
    final url = Uri.parse(
        '${global.urlPrefix}${global.artists}${widget.artistId}${global.tracksTop}?${global.apiKey}&${global.tracksLimit}$offset');
    var rawData = await global.httpGetAndDecode(url) as Map<String, dynamic>;
    List<dynamic> data = rawData[global.textTracks];
    tracks.addAll(data.map((artist) => Track.fromJson(artist)));
    isLoading = false;
    setState(() {});
    return true;
  }

  @override
  void initState() {
    super.initState();
    _getTracksTop();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ...tracks
            .map((track) => Container(
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
                        "${global.urlPrefix}${global.pathAlbumsImageserver}${track.albumId}"
                        "${global.pathImage}${global.album70x70}${global.extension}",
                        frameBuilder: (_, child, frame, __) {
                          return frame == null
                              ? const SizedBox(
                                  height: 65,
                                  width: 65,
                                )
                              : child;
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 65,
                            width: 65,
                            child: Center(child: Text('NO IMAGE')),
                          );
                        },
                        fit: BoxFit.contain,
                        width: 65,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              track.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              track.albumName ?? '',
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
                              builder: (context) => BottomSheetPlayer(
                                track: track,
                              ),
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
                  onPressed: () => _getTracksTop(),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text(
                        loadButtonText,
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
