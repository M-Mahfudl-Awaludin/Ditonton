import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeasonPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-season';

  final int id;
  final int seasonNumber;
  final String seasonName;

  TVSeasonPage({
    required this.id,
    required this.seasonNumber,
    required this.seasonName,
  });

  @override
  _TVSeasonPageState createState() => _TVSeasonPageState();
}

class _TVSeasonPageState extends State<TVSeasonPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<TVDetailCubit>()
        .fetchSeasonDetail(widget.id, widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.seasonName),
      ),
      body: BlocBuilder<TVDetailCubit, TVDetailState>(
        builder: (_, data) {
          if (data.seasonState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (data.seasonState == RequestState.Loaded) {
            final season = data.seasonDetail;
            if (season == null || season.episodes.isEmpty) {
              return Center(child: Text('No episode data available'));
            }
            return ListView.builder(
              key: Key('episodeList'),
              padding: const EdgeInsets.all(8),
              itemCount: season.episodes.length,
              itemBuilder: (_, index) {
                final Episode episode = season.episodes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: episode.stillPath != null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      '$baseImageUrl${episode.stillPath}',
                                  width: 100,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (_, __, ___) =>
                                      Icon(Icons.error),
                                )
                              : Container(
                                  width: 100,
                                  height: 60,
                                  color: grey,
                                  child: Icon(Icons.tv),
                                ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Episode ${episode.episodeNumber}: ${episode.name}',
                                style: subtitle,
                              ),
                              if (episode.airDate != null)
                                Text(
                                  episode.airDate!,
                                  style: TextStyle(fontSize: 12),
                                ),
                              SizedBox(height: 4),
                              Text(
                                episode.overview?.isNotEmpty == true
                                    ? episode.overview!
                                    : 'No overview available.',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: bodyText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
