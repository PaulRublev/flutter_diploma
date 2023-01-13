import 'package:diplom_spotify/src/utils/track.dart';
import 'package:diplom_spotify/src/widgets/utility_widgets/custom_circular_progress_indicator.dart';
import 'package:diplom_spotify/src/widgets/utility_widgets/track_list_tile.dart';
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
        ...tracks.map((track) => TrackListTile(track: track)).toList(),
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
