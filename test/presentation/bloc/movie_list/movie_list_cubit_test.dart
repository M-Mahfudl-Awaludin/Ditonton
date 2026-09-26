import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
  });

  MovieListCubit buildCubit() => MovieListCubit(
        getNowPlayingMovies: mockGetNowPlayingMovies,
        getPopularMovies: mockGetPopularMovies,
        getTopRatedMovies: mockGetTopRatedMovies,
      );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(buildCubit().state, const MovieListState());
  });

  group('now playing movies', () {
    blocTest<MovieListCubit, MovieListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchNowPlayingMovies(),
      expect: () => [
        const MovieListState(nowPlayingState: RequestState.Loading),
        MovieListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
      verify: (_) => verify(mockGetNowPlayingMovies.execute()),
    );

    blocTest<MovieListCubit, MovieListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchNowPlayingMovies(),
      expect: () => [
        const MovieListState(nowPlayingState: RequestState.Loading),
        const MovieListState(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('popular movies', () {
    blocTest<MovieListCubit, MovieListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [
        const MovieListState(popularMoviesState: RequestState.Loading),
        MovieListState(
          popularMoviesState: RequestState.Loaded,
          popularMovies: tMovieList,
        ),
      ],
      verify: (_) => verify(mockGetPopularMovies.execute()),
    );

    blocTest<MovieListCubit, MovieListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [
        const MovieListState(popularMoviesState: RequestState.Loading),
        const MovieListState(
          popularMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('top rated movies', () {
    blocTest<MovieListCubit, MovieListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchTopRatedMovies(),
      expect: () => [
        const MovieListState(topRatedMoviesState: RequestState.Loading),
        MovieListState(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: tMovieList,
        ),
      ],
      verify: (_) => verify(mockGetTopRatedMovies.execute()),
    );

    blocTest<MovieListCubit, MovieListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchTopRatedMovies(),
      expect: () => [
        const MovieListState(topRatedMoviesState: RequestState.Loading),
        const MovieListState(
          topRatedMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
