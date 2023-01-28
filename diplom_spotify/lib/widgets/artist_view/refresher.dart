import 'package:diplom_spotify/widgets/artist_view/artist_grid.dart';
import 'package:diplom_spotify/widgets/utility_widgets/styled_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Refresher extends StatelessWidget {
  final String? search;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ArtistsState state;
  final Function(String?) request;

  Refresher({
    super.key,
    this.search,
    required this.state,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    refreshController.loadComplete();

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
        onLoading: () async {
          await request(search);
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
          itemCount: state.artists.length,
          itemBuilder: (BuildContext context, int index) {
            return ArtistGrid(artist: state.artists[index]);
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
