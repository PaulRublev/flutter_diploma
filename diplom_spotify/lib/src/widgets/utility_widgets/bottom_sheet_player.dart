import 'package:diplom_spotify/src/utils/track.dart';
import 'package:flutter/material.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;

class BottomSheetPlayer extends StatefulWidget {
  final Track track;

  const BottomSheetPlayer({super.key, required this.track});

  @override
  State<BottomSheetPlayer> createState() => _BottomSheetPlayerState();
}

class _BottomSheetPlayerState extends State<BottomSheetPlayer> {
  static const collectionButtonText = 'В коллекцию';

  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(25),
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Image.network(
                  "${global.urlPrefix}${global.pathAlbumsImageserver}${widget.track.albumId}"
                  "${global.pathImage}${global.album170x170}${global.extension}",
                  frameBuilder: (_, child, frame, __) {
                    return frame == null ? const SizedBox() : child;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Center(
                          child: Text(
                        'NO IMAGE',
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                  },
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.track.albumName ?? '',
                        style: Theme.of(context).textTheme.overline,
                      ),
                      const Spacer(flex: 2),
                      Text(
                        widget.track.name ?? '',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const Spacer(flex: 5),
                      ElevatedButton(
                        onPressed: () {},
                        child: SizedBox(
                          height: 30,
                          width: 120,
                          child: Center(
                            child: Text(
                              collectionButtonText,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                splashRadius: 1,
                padding: const EdgeInsets.all(1),
                onPressed: () {},
                icon: const Icon(Icons.play_circle_outline_rounded),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Slider(
                        divisions: 180,
                        value: sliderValue,
                        max: 180,
                        onChanged: (value) {
                          sliderValue = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'data',
                          style: Theme.of(context).textTheme.overline,
                        ),
                        const Spacer(flex: 10),
                        Text(
                          'data',
                          style: Theme.of(context).textTheme.overline,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
