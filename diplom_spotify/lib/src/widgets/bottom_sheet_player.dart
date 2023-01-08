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
              SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'data',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      const Spacer(flex: 2),
                      Text(
                        'Title',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.12,
                        ),
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
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
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
          SizedBox(height: 18),
          Row(
            children: [
              IconButton(
                splashRadius: 1,
                iconSize: 27.5,
                padding: EdgeInsets.all(1),
                color: Theme.of(context).colorScheme.secondary,
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
                          print(value.toString());
                          sliderValue = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          'data',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Spacer(flex: 10),
                        Text(
                          'data',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Spacer(),
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
