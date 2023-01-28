import 'package:diplom_spotify/widgets/artist_view/refresher.dart';
import 'package:diplom_spotify/widgets/utility_widgets/styled_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';

class ArtistsGridView extends StatefulWidget {
  final String? search;
  final ArtistsState state;
  final Function(String?) request;

  const ArtistsGridView({
    super.key,
    this.search,
    required this.state,
    required this.request,
  });

  @override
  State<ArtistsGridView> createState() => _ArtistsGridViewState();
}

class _ArtistsGridViewState extends State<ArtistsGridView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.request(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (widget.state.status) {
      case ArtistsStatus.failure:
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Что-то пошло не так!',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              IconButton(
                onPressed: () {
                  widget.request(widget.search);
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        );
      case ArtistsStatus.waiting:
      case ArtistsStatus.loading:
        if (widget.state.artists.isEmpty) {
          return const Align(
            alignment: Alignment.topCenter,
            child: StyledCircularProgressIndicator(),
          );
        } else {
          return Refresher(
            search: widget.search,
            state: widget.state,
            request: widget.request,
          );
        }
      case ArtistsStatus.success:
        if (widget.state.artists.isEmpty) {
          return Center(
            child: Text(
              'Ничего не найдено',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        }

        return Refresher(
          search: widget.search,
          state: widget.state,
          request: widget.request,
        );
      default:
        return Container();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
