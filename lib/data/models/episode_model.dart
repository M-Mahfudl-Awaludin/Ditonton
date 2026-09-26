import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.airDate,
    required this.episodeNumber,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.runtime,
  });

  final int id;
  final String name;
  final String? overview;
  final String? airDate;
  final int episodeNumber;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int? runtime;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json["id"],
      name: json["name"] ?? '',
      overview: json["overview"],
      airDate: json["air_date"],
      episodeNumber: json["episode_number"] ?? 0,
      seasonNumber: json["season_number"] ?? 0,
      stillPath: json["still_path"],
      voteAverage: (json["vote_average"] ?? 0).toDouble(),
      runtime: json["runtime"],
    );
  }

  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      overview: overview,
      airDate: airDate,
      episodeNumber: episodeNumber,
      seasonNumber: seasonNumber,
      stillPath: stillPath,
      voteAverage: voteAverage,
      runtime: runtime,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      airDate,
      episodeNumber,
      seasonNumber,
      stillPath,
      voteAverage,
      runtime,
    ];
  }
}
