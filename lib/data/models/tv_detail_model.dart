import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVDetailResponse extends Equatable {
  TVDetailResponse({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.inProduction,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final bool inProduction;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<SeasonModel> seasons;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) {
    return TVDetailResponse(
      backdropPath: json["backdrop_path"],
      episodeRunTime:
          List<int>.from((json["episode_run_time"] ?? []).map((x) => x)),
      firstAirDate: json["first_air_date"] ?? '',
      genres: List<GenreModel>.from(
          (json["genres"] ?? []).map((x) => GenreModel.fromJson(x))),
      id: json["id"],
      inProduction: json["in_production"] ?? false,
      lastAirDate: json["last_air_date"] ?? '',
      name: json["name"] ?? '',
      numberOfEpisodes: json["number_of_episodes"] ?? 0,
      numberOfSeasons: json["number_of_seasons"] ?? 0,
      originalName: json["original_name"] ?? '',
      overview: json["overview"] ?? '',
      popularity: (json["popularity"] ?? 0).toDouble(),
      posterPath: json["poster_path"] ?? '',
      seasons: List<SeasonModel>.from(
          (json["seasons"] ?? []).map((x) => SeasonModel.fromJson(x))),
      status: json["status"] ?? '',
      tagline: json["tagline"] ?? '',
      voteAverage: (json["vote_average"] ?? 0).toDouble(),
      voteCount: json["vote_count"] ?? 0,
    );
  }

  TVDetail toEntity() {
    return TVDetail(
      backdropPath: this.backdropPath,
      episodeRunTime: this.episodeRunTime,
      firstAirDate: this.firstAirDate,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      inProduction: this.inProduction,
      lastAirDate: this.lastAirDate,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
      status: this.status,
      tagline: this.tagline,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props {
    return [
      backdropPath,
      episodeRunTime,
      firstAirDate,
      genres,
      id,
      inProduction,
      lastAirDate,
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originalName,
      overview,
      popularity,
      posterPath,
      seasons,
      status,
      tagline,
      voteAverage,
      voteCount,
    ];
  }
}
