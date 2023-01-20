import 'package:diplom_spotify/widgets/utility_widgets/custom_circular_progress_indicator.dart';
import 'package:diplom_spotify/widgets/utility_widgets/track_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';

class SliverTracksList extends StatefulWidget {
  final String artistId;

  const SliverTracksList({super.key, required this.artistId});

  @override
  State<SliverTracksList> createState() => _SliverTracksListState();
}

class _SliverTracksListState extends State<SliverTracksList> {
  bool isLoading = true;
  final List<Track> tracks = [];
  final artistsService = BlocFactory.instance.mainBloc.networkService;

  @override
  void initState() {
    super.initState();
    BlocFactory.instance.refreshNetworkService();
    artistsService.initialize();
    getTracks();
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
                  onPressed: () => getTracks(),
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

  void getTracks() async {
    isLoading = true;
    setState(() {});
    tracks.addAll(await artistsService.getTracksTop(widget.artistId));
    isLoading = false;
    setState(() {});
  }
}
