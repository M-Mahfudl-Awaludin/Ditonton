import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_cubit.dart';
import 'package:ditonton/presentation/pages/tv_season_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TVDetailPage({required this.id});

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVDetailCubit>().fetchTVDetail(widget.id);
      context.read<TVDetailCubit>().loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVDetailCubit, TVDetailState>(
        builder: (_, state) {
          if (state.tvState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tvState == RequestState.Loaded) {
            final tv = state.tv!;
            return SafeArea(
              child: DetailTVContent(
                tv,
                state.tvRecommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(state.message);
          }
        },
      ),
    );
  }
}

class DetailTVContent extends StatelessWidget {
  final TVDetail tv;
  final List<TV> recommendations;
  final bool isAddedWatchlist;

  DetailTVContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (_, __) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (_, __, ___) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: richBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: heading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final cubit = context.read<TVDetailCubit>();
                                if (!isAddedWatchlist) {
                                  await cubit.addWatchlist(tv);
                                } else {
                                  await cubit.removeFromWatchlist(tv);
                                }

                                final message = cubit.state.watchlistMessage;

                                if (message ==
                                        TVDetailCubit
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TVDetailCubit
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              _showDuration(tv.episodeRunTime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (_, __) => Icon(
                                    Icons.star,
                                    color: mikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: heading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: heading6,
                            ),
                            Text(
                              '${tv.numberOfSeasons} season(s), ${tv.numberOfEpisodes} episode(s)',
                              style: bodyText,
                            ),
                            SizedBox(height: 8),
                            _SeasonList(tvId: tv.id, seasons: tv.seasons),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: heading6,
                            ),
                            BlocBuilder<TVDetailCubit, TVDetailState>(
                              builder: (_, data) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvRec = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVDetailPage.ROUTE_NAME,
                                                arguments: tvRec.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvRec.posterPath}',
                                                placeholder: (_, __) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (_, __, ___) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: richBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(List<int> episodeRunTime) {
    if (episodeRunTime.isEmpty) {
      return '';
    }
    final int runtime = episodeRunTime.first;
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m per episode';
    } else {
      return '${minutes}m per episode';
    }
  }
}

class _SeasonList extends StatelessWidget {
  final int tvId;
  final List<Season> seasons;

  _SeasonList({required this.tvId, required this.seasons});

  @override
  Widget build(BuildContext context) {
    if (seasons.isEmpty) {
      return Text('No season information available.');
    }
    return Container(
      key: Key('seasonList'),
      height: 184,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: seasons.length,
        itemBuilder: (context, index) {
          final season = seasons[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                TVSeasonPage.ROUTE_NAME,
                arguments: {
                  'id': tvId,
                  'seasonNumber': season.seasonNumber,
                  'seasonName': season.name,
                },
              );
            },
            child: Container(
              width: 110,
              margin: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: season.posterPath != null
                        ? CachedNetworkImage(
                            imageUrl: '$baseImageUrl${season.posterPath}',
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (_, __, ___) =>
                                Icon(Icons.error),
                          )
                        : Container(
                            height: 110,
                            width: 110,
                            color: grey,
                            child: Icon(Icons.tv),
                          ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    season.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bodyText,
                  ),
                  if (season.episodeCount != null)
                    Text(
                      '${season.episodeCount} episodes',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
