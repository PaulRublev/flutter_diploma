import 'package:diplom_spotify/widgets/utility_widgets/styled_circular_progress_indicator.dart';
import 'package:diplom_spotify/widgets/utility_widgets/track_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

class SliverTracksList extends StatefulWidget {
  final String artistId;

  const SliverTracksList({super.key, required this.artistId});

  @override
  State<SliverTracksList> createState() => _SliverTracksListState();
}

class _SliverTracksListState extends State<SliverTracksList> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<TopTracksCubit>().getInitialTopTracks(widget.artistId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopTracksCubit, TopTracksState>(
      builder: (context, state) {
        isLoading = state.status == TopTracksStatus.waiting ||
            state.status == TopTracksStatus.loading;

        return SliverList(
          delegate: SliverChildListDelegate([
            ...state.tracks
                .map((track) => TrackListTile(track: track))
                .toList(),
            Stack(
              children: [
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    height: 50,
                    width: isLoading ? 50 : 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: isLoading
                        ? Container()
                        : ElevatedButton(
                            onPressed: () => context
                                .read<TopTracksCubit>()
                                .getTopTracks(widget.artistId),
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
                ),
                Center(
                  child: isLoading
                      ? const StyledCircularProgressIndicator()
                      : Container(),
                ),
              ],
            ),
            const SizedBox(height: 60),
          ]),
        );
      },
    );
  }
}
