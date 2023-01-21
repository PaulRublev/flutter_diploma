import 'dart:async';

import 'package:diplom_spotify/widgets/artist_view/custom_refresher.dart';
import 'package:diplom_spotify/widgets/utility_widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
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
  final networkService = BlocFactory.instance.mainBloc.networkService;
  Timer? reloadTimer;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    BlocFactory.instance.refreshNetworkService();
    networkService.initialize();
    _request = networkService.getArtists(widget.search);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(snapshot.error.toString()),
                    IconButton(
                      onPressed: () {
                        networkService.initialize();
                        _request = networkService.getArtists(widget.search);
                        setState(() {});
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
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

              return CustomRefresher(
                onLoading: _loading,
                refreshController: refreshController,
                artists: artists,
              );
            }

            return Container();
          default:
            return Container();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _loading() async {
    if (refreshController.footerStatus == LoadStatus.loading) {
      if (reloadTimer?.isActive ?? false) {
        reloadTimer?.cancel();
      }
      reloadTimer = Timer(
        const Duration(seconds: 5),
        () {
          setState(() {
            _loading();
          });
        },
      );
    }
    // todo try/catch
    artists.addAll(await networkService.getArtists(widget.search));
    if (reloadTimer?.isActive ?? false) {
      reloadTimer?.cancel();
    }
    refreshController.loadComplete();
    if (mounted) setState(() {});
  }
}
