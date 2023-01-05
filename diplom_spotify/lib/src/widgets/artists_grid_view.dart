import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'custom_circular_progress_indicator.dart';

class ArtistsGridView extends StatefulWidget {
  const ArtistsGridView({super.key, required this.storageKeyName});

  final String storageKeyName;

  @override
  State<ArtistsGridView> createState() => _ArtistsGridViewState();
}

class _ArtistsGridViewState extends State<ArtistsGridView> {
  int itemCount = 10;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    itemCount = itemCount + 10;
    if (mounted) setState(() {});
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      footerTriggerDistance: -65,
      bottomHitBoundary: 0,
      maxUnderScrollExtent: 100,
      child: SmartRefresher(
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            switch (mode) {
              case LoadStatus.idle:
              case LoadStatus.canLoading:
              case LoadStatus.loading:
                body = const CustomCircularProgressIndicator();
                break;
              case LoadStatus.failed:
                body = const Text("Load Failed!Click retry!");
                break;
              default:
                body = const Text("No more Data");
            }

            return SizedBox(
              height: 60.0,
              child: Center(child: body),
            );
          },
        ),
        enablePullUp: true,
        enablePullDown: false,
        onLoading: _onLoading,
        controller: refreshController,
        child: GridView.builder(
          key: PageStorageKey(widget.storageKeyName),
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 15,
            bottom: 10,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.3,
          ),
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              clipBehavior: Clip.antiAlias,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      'https://i.postimg.cc/1tf6qqQP/grozny.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    child: Center(
                      child: Text(index.toString()),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
