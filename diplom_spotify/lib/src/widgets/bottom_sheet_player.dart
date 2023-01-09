import 'package:flutter/material.dart';

class BottomSheetPlayer extends StatefulWidget {
  const BottomSheetPlayer({super.key});

  @override
  State<BottomSheetPlayer> createState() => _BottomSheetPlayerState();
}

class _BottomSheetPlayerState extends State<BottomSheetPlayer> {
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
                ),
                child: Image.network(
                  'https://i.postimg.cc/1tf6qqQP/grozny.jpg',
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
                        'data',
                        style: Theme.of(context).textTheme.overline,
                      ),
                      const Spacer(flex: 2),
                      Text(
                        'Title',
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
                              'В коллекцию',
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
