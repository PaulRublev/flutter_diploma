import 'package:diplom_spotify/widgets/artist_view/artist_grid.dart';
import 'package:diplom_spotify/widgets/utility_widgets/styled_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Refresher extends StatelessWidget {
  final Function onLoading;
  final RefreshController refreshController;
  final List<Artist> artists;

  const Refresher({
    super.key,
    required this.onLoading,
    required this.refreshController,
    required this.artists,
  });

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
          builder: _buildCustomFooter,
        ),
        enablePullUp: true,
        enablePullDown: false,
        onLoading: () {
          onLoading();
        },
        controller: refreshController,
        child: GridView.builder(
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
          itemCount: artists.length,
          itemBuilder: (BuildContext context, int index) {
            return ArtistGrid(artist: artists[index]);
          },
        ),
      ),
    );
  }

  Widget _buildCustomFooter(BuildContext context, LoadStatus? mode) {
    Widget body;
    switch (mode) {
      case LoadStatus.idle:
      case LoadStatus.canLoading:
      case LoadStatus.loading:
        body = const StyledCircularProgressIndicator();
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
  }
}
