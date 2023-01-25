import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class BottomSheetPlayerControl extends StatelessWidget {
  final Duration? currentDuration;
  final AudioPlayer? audioPlayer;

  const BottomSheetPlayerControl(
      {super.key, this.currentDuration, this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
          child: (currentDuration == null || audioPlayer == null)
              ? Slider(
                  value: 0,
                  onChanged: (value) {},
                )
              : Slider(
                  divisions: 180,
                  value: (currentDuration?.inMilliseconds ?? 0).toDouble(),
                  max: (audioPlayer?.duration?.inMilliseconds ?? 0).toDouble() +
                      10.0,
                  onChanged: (value) {
                    audioPlayer?.seek(Duration(milliseconds: value.toInt()));
                  },
                ),
        ),
        Row(
          children: [
            const Spacer(),
            Text(
              currentDuration?.toString().split('.')[0] ?? '-',
              style: Theme.of(context).textTheme.overline,
            ),
            const Spacer(flex: 10),
            Text(
              audioPlayer?.duration?.toString().split('.')[0] ?? '-',
              style: Theme.of(context).textTheme.overline,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
