import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeasonDetailResponse extends Equatable {
  TVSeasonDetailResponse({
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
  final List<EpisodeModel> episodes;

  factory TVSeasonDetailResponse.fromJson(Map<String, dynamic> json) {
    return TVSeasonDetailResponse(
      id: json["id"],
      name: json["name"] ?? '',
      overview: json["overview"],
      seasonNumber: json["season_number"] ?? 0,
      posterPath: json["poster_path"],
      airDate: json["air_date"],
      episodes: List<EpisodeModel>.from(
          (json["episodes"] ?? []).map((x) => EpisodeModel.fromJson(x))),
    );
  }

  TVSeasonDetail toEntity() {
    return TVSeasonDetail(
      id: id,
      name: name,
      overview: overview,
      seasonNumber: seasonNumber,
      posterPath: posterPath,
      airDate: airDate,
      episodes: episodes.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props =>
      [id, name, overview, seasonNumber, posterPath, airDate, episodes];
}
