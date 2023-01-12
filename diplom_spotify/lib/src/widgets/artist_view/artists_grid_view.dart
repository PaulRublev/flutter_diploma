import 'package:diplom_spotify/src/widgets/artist_view/artist_grid.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:diplom_spotify/src/utils/artist.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;

import '../utility_widgets/custom_circular_progress_indicator.dart';

class ArtistsGridView extends StatefulWidget {
  const ArtistsGridView({super.key});

  @override
  State<ArtistsGridView> createState() => _ArtistsGridViewState();
}

class _ArtistsGridViewState extends State<ArtistsGridView>
    with AutomaticKeepAliveClientMixin {
  static const artistsTop = '/v2.2/artists/top';
  static const limit = 'limit=10';
  static const textArtists = 'artists';

  int _offset = 0;
  late Future<bool> _getTop;
  final List<Artist> artists = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<bool> _getArtistsTop() async {
    final offset = _offset == 0 ? '' : '&offset=$_offset';
    _offset += 10;
    final url = Uri.parse(
        '${global.urlPrefix}$artistsTop?${global.apiKey}&$limit$offset');
    var rawData = await global.httpGetAndDecode(url) as Map<String, dynamic>;
    List<dynamic> data = rawData[textArtists];
    artists.addAll(data.map((artist) => Artist.fromJson(artist)));
    refreshController.loadComplete();
    return true;
  }

  @override
  void initState() {
    super.initState();
    _getTop = _getArtistsTop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
        future: _getTop,
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
              } else if (snapshot.hasData) {
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
                      await _getArtistsTop();
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
