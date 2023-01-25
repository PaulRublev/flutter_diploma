import 'package:diplom_spotify/utils/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final NapsterTrack track;

  const FavoriteButton({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteTracksNotifier>(
      builder: (context, favoriteTracks, child) {
        if (favoriteTracks.subscription == null) return Container();
        final isInCollection = favoriteTracks.tracks.contains(track);
        return SizedBox(
          height: 30,
          width: 120,
          child: isInCollection
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'В коллекции',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Icon(
                          Icons.check,
                          size: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    BlocFactory.instance.mainBloc.firebaseService
                        .addTrack(track.id);
                  },
                  child: Center(
                    child: Text(
                      'В коллекцию',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
