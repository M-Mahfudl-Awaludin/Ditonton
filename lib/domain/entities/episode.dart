import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
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
