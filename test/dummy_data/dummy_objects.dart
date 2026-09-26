import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_season_detail_model.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// ==================== TV Series Dummy Data ====================
final testTV = TV(
  backdropPath: '/backdrop.jpg',
  genreIds: [18, 10765],
  id: 1399,
  name: 'Game of Thrones',
  originalName: 'Game of Thrones',
  overview: 'Seven noble families fight for control of the mythical land of Westeros.',
  popularity: 369.594,
  posterPath: '/poster.jpg',
  firstAirDate: '2011-04-17',
  voteAverage: 8.3,
  voteCount: 11504,
);

final testTVList = [testTV];

final testSeason = Season(
  airDate: '2011-04-17',
  episodeCount: 10,
  id: 3624,
  name: 'Season 1',
  overview: 'overview',
  posterPath: '/season1.jpg',
  seasonNumber: 1,
);

final testTVDetail = TVDetail(
  backdropPath: 'backdropPath',
  episodeRunTime: [60],
  firstAirDate: '2011-04-17',
  genres: [Genre(id: 18, name: 'Drama')],
  id: 1399,
  inProduction: false,
  lastAirDate: '2019-05-19',
  name: 'Game of Thrones',
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  originalName: 'Game of Thrones',
  overview: 'overview',
  popularity: 369.594,
  posterPath: 'posterPath',
  seasons: [testSeason],
  status: 'Ended',
  tagline: 'Winter Is Coming',
  voteAverage: 8.3,
  voteCount: 11504,
);

final testWatchlistTV = TV.watchlist(
  id: 1399,
  name: 'Game of Thrones',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1399,
  name: 'Game of Thrones',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVMap = {
  'id': 1399,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'Game of Thrones',
};

final testEpisode = Episode(
  id: 63056,
  name: 'Winter Is Coming',
  overview: 'Ned Stark, Lord of Winterfell, learns...',
  airDate: '2011-04-17',
  episodeNumber: 1,
  seasonNumber: 1,
  stillPath: '/still.jpg',
  voteAverage: 7.9,
  runtime: 62,
);

final testTVSeasonDetail = TVSeasonDetail(
  id: 3624,
  name: 'Season 1',
  overview: 'overview',
  seasonNumber: 1,
  posterPath: '/season1.jpg',
  airDate: '2011-04-17',
  episodes: [testEpisode],
);

// Model-level (data layer) dummy responses used by repository tests.
final testTVDetailResponse = TVDetailResponse(
  backdropPath: 'backdropPath',
  episodeRunTime: [60],
  firstAirDate: '2011-04-17',
  genres: [GenreModel(id: 18, name: 'Drama')],
  id: 1399,
  inProduction: false,
  lastAirDate: '2019-05-19',
  name: 'Game of Thrones',
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  originalName: 'Game of Thrones',
  overview: 'overview',
  popularity: 369.594,
  posterPath: 'posterPath',
  seasons: [testSeasonModel],
  status: 'Ended',
  tagline: 'Winter Is Coming',
  voteAverage: 8.3,
  voteCount: 11504,
);

final testSeasonModel = SeasonModel(
  airDate: '2011-04-17',
  episodeCount: 10,
  id: 3624,
  name: 'Season 1',
  overview: 'overview',
  posterPath: '/season1.jpg',
  seasonNumber: 1,
);

final testEpisodeModel = EpisodeModel(
  id: 63056,
  name: 'Winter Is Coming',
  overview: 'Ned Stark, Lord of Winterfell, learns...',
  airDate: '2011-04-17',
  episodeNumber: 1,
  seasonNumber: 1,
  stillPath: '/still.jpg',
  voteAverage: 7.9,
  runtime: 62,
);

final testTVSeasonDetailResponse = TVSeasonDetailResponse(
  id: 3624,
  name: 'Season 1',
  overview: 'overview',
  seasonNumber: 1,
  posterPath: '/season1.jpg',
  airDate: '2011-04-17',
  episodes: [testEpisodeModel],
);
