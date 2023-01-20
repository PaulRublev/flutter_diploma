import 'package:diplom_spotify/src/widgets/artist_view/artist_grid.dart';
import 'package:diplom_spotify/src/widgets/utility_widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;

class ArtistsGridView extends StatefulWidget {
  final String? search;

  const ArtistsGridView({super.key, this.search});

  @override
  State<ArtistsGridView> createState() => _ArtistsGridViewState();
}

class _ArtistsGridViewState extends State<ArtistsGridView>
    with AutomaticKeepAliveClientMixin {
  static const searchText = 'searchText';

  int _offset = 0;
  late Future<List<Artist>> _request;
  final List<Artist> artists = [];
  final String urlTop = "${global.urlPrefix}${global.artistsTop}?"
      "${global.apiKey}&${global.artistsLimit}";
  final String urlSearch = "${global.urlPrefix}${global.artistsSearch}?"
      "${global.apiKey}&${global.queryText}=$searchText&${global.searchLimit}";
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _request = _getArtists();
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
                      artists.addAll(await _getArtists());
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

  Future<List<Artist>> _getArtists() async {
    final offset = _offset == 0 ? '' : '&offset=$_offset';
    _offset += 10;
    var uri = '';
    if (widget.search != null) {
      uri = urlSearch.replaceFirst(searchText, widget.search ?? '');
    } else {
      uri = urlTop;
    }
    final url = Uri.parse('$uri$offset');
    var rawData = await global.httpGetAndDecode(url) as Map<String, dynamic>;
    if (widget.search != null) {
      rawData =
          rawData[global.searchText][global.dataText] as Map<String, dynamic>;
    }
    List<dynamic> data = rawData[global.textArtists];
    refreshController.loadComplete();
    return data.map((artist) => Artist.fromJson(artist)).toList();
  }
}
