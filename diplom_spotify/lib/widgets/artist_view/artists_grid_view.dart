import 'package:diplom_spotify/utils/artists_network_service.dart';
import 'package:diplom_spotify/widgets/artist_view/artist_grid.dart';
import 'package:diplom_spotify/widgets/utility_widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArtistsGridView extends StatefulWidget {
  final String? search;

  const ArtistsGridView({super.key, this.search});

  @override
  State<ArtistsGridView> createState() => _ArtistsGridViewState();
}

class _ArtistsGridViewState extends State<ArtistsGridView>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Artist>> _request;
  final List<Artist> artists = [];
  final ArtistsNetworkService artistsService = ArtistsNetworkService();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    artistsService.initialize(widget.search);
    _request = artistsService.getArtists();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
        future: _request,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Align(
                alignment: Alignment.topCenter,
                child: CustomCircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData) {
                if (artists.isEmpty) {
                  artists.addAll(snapshot.data ?? []);
                }
                if (artists.isEmpty) {
                  return Center(
                    child: Text(
                      'Ничего не найдено',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  );
                }

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
                    onLoading: () async {
                      artists.addAll(await artistsService.getArtists());
                      refreshController.loadComplete();
                      if (mounted) setState(() {});
                    },
                    controller: refreshController,
                    child: GridView.builder(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 15,
                        bottom: 10,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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

              return Container();
            default:
              return Container();
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
