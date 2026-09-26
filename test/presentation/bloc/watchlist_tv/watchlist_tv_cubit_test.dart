import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistTV extends Mock implements GetWatchlistTV {
  @override
  Future<Either<Failure, List<TV>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<Either<Failure, List<TV>>>.value(Right(<TV>[])))
          as Future<Either<Failure, List<TV>>>);
}

void main() {
  late MockGetWatchlistTV mockGetWatchlistTV;

  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTV();
  });

  test('initial state should be empty', () {
    expect(WatchlistTVCubit(getWatchlistTV: mockGetWatchlistTV).state,
        const WatchlistTVState());
  });

  blocTest<WatchlistTVCubit, WatchlistTVState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTV.execute())
          .thenAnswer((_) async => Right(testTVList));
      return WatchlistTVCubit(getWatchlistTV: mockGetWatchlistTV);
    },
    act: (cubit) => cubit.fetchWatchlistTV(),
    expect: () => [
      const WatchlistTVState(watchlistState: RequestState.Loading),
      WatchlistTVState(
        watchlistState: RequestState.Loaded,
        watchlistTV: testTVList,
      ),
    ],
    verify: (_) => verify(mockGetWatchlistTV.execute()),
  );

  blocTest<WatchlistTVCubit, WatchlistTVState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTV.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return WatchlistTVCubit(getWatchlistTV: mockGetWatchlistTV);
    },
    act: (cubit) => cubit.fetchWatchlistTV(),
    expect: () => [
      const WatchlistTVState(watchlistState: RequestState.Loading),
      const WatchlistTVState(
        watchlistState: RequestState.Error,
        message: 'Database Failure',
      ),
    ],
  );
}
