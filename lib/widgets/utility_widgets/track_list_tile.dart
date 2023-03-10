import 'package:diplom_spotify/widgets/player/bottom_sheet_player.dart';
import 'package:diplom_spotify/widgets/player/player_button.dart';
import 'package:diplom_spotify/widgets/utility_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';

class TrackListTile extends StatelessWidget {
  final NapsterTrack track;
  final bool isFavorite;

  const TrackListTile(
      {super.key, required this.track, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0x00000000),
        useRootNavigator: true,
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<TracklistCubit>(context),
          child: BottomSheetPlayer(
            track: track,
          ),
        ),
      ),
      child: Container(
        height: 65,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: !isFavorite
              ? Theme.of(context).colorScheme.background
              : Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 15,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 65,
              width: 65,
              child: CachedImage.album70x70(albumId: track.albumId),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    track.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    track.albumName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Material(
                color: !isFavorite
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).dialogBackgroundColor,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: PlayerButton(trackUri: track.previewURL),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
