import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class TVSeasonDetail extends Equatable {
  TVSeasonDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.posterPath,
    required this.airDate,
    required this.episodes,
  });

  final int id;
  final String name;
  final String? overview;
  final int seasonNumber;
  final String? posterPath;
  final String? airDate;
  final List<Episode> episodes;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      seasonNumber,
      posterPath,
      airDate,
      episodes,
    ];
  }
}
