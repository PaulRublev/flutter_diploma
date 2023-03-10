import 'package:diplom_spotify/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';

class FavoriteButton extends StatelessWidget {
  final NapsterTrack track;

  const FavoriteButton({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TracklistCubit, TracklistState>(
      builder: (context, state) {
        if (state.status == TracklistStatus.loading) return Container();
        final bool isInCollection = state.tracks.contains(track);
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
                          AppLocalizations.of(context)!.isInFavorites,
                          style: Theme.of(context).textTheme.bodyLarge,
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
                    context.read<TracklistCubit>().addTrack(track);
                  },
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.addToFavorites,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
