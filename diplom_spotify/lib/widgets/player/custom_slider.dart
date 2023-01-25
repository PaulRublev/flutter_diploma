import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomSlider extends StatelessWidget {
  final Duration? currentDuration;
  final AudioPlayer? audioPlayer;

  const CustomSlider({super.key, this.currentDuration, this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
          child: Slider(
            divisions: 180,
            value: (currentDuration?.inMilliseconds ?? 0).toDouble(),
            max: (audioPlayer?.duration?.inMilliseconds ?? 0).toDouble() + 10.0,
            onChanged: (value) {
              audioPlayer?.seek(Duration(milliseconds: value.toInt()));
            },
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Text(
              // todo !!
              currentDuration?.toString().substring(0, 7) ?? '-',
              style: Theme.of(context).textTheme.overline,
            ),
            const Spacer(flex: 10),
            Text(
              audioPlayer?.duration?.toString().substring(0, 7) ?? '-',
              style: Theme.of(context).textTheme.overline,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
