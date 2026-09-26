import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
  });

  test('initial state should be empty', () {
    expect(WatchlistMovieCubit(getWatchlistMovies: mockGetWatchlistMovies).state,
        const WatchlistMovieState());
  });

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return WatchlistMovieCubit(getWatchlistMovies: mockGetWatchlistMovies);
    },
    act: (cubit) => cubit.fetchWatchlistMovies(),
    expect: () => [
      const WatchlistMovieState(watchlistState: RequestState.Loading),
      WatchlistMovieState(
        watchlistState: RequestState.Loaded,
        watchlistMovies: [testWatchlistMovie],
      ),
    ],
    verify: (_) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return WatchlistMovieCubit(getWatchlistMovies: mockGetWatchlistMovies);
    },
    act: (cubit) => cubit.fetchWatchlistMovies(),
    expect: () => [
      const WatchlistMovieState(watchlistState: RequestState.Loading),
      const WatchlistMovieState(
        watchlistState: RequestState.Error,
        message: "Can't get data",
      ),
    ],
  );
}
