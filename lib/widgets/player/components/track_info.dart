import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class TrackInfo extends StatelessWidget {
  final NapsterTrack track;

  const TrackInfo({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            track.albumName,
            maxLines: 1,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const Spacer(),
          Text(
            track.name,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
