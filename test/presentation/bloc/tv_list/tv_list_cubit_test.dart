import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetOnTheAirTV extends Mock implements GetOnTheAirTV {
  @override
  Future<Either<Failure, List<TV>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<Either<Failure, List<TV>>>.value(
                  Right(<TV>[])))
          as Future<Either<Failure, List<TV>>>);
}

class MockGetPopularTV extends Mock implements GetPopularTV {
  @override
  Future<Either<Failure, List<TV>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<Either<Failure, List<TV>>>.value(
                  Right(<TV>[])))
          as Future<Either<Failure, List<TV>>>);
}

class MockGetTopRatedTV extends Mock implements GetTopRatedTV {
  @override
  Future<Either<Failure, List<TV>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<Either<Failure, List<TV>>>.value(
                  Right(<TV>[])))
          as Future<Either<Failure, List<TV>>>);
}

void main() {
  late MockGetOnTheAirTV mockGetOnTheAirTV;
  late MockGetPopularTV mockGetPopularTV;
  late MockGetTopRatedTV mockGetTopRatedTV;

  setUp(() {
    mockGetOnTheAirTV = MockGetOnTheAirTV();
    mockGetPopularTV = MockGetPopularTV();
    mockGetTopRatedTV = MockGetTopRatedTV();
  });

  TVListCubit buildCubit() => TVListCubit(
        getOnTheAirTV: mockGetOnTheAirTV,
        getPopularTV: mockGetPopularTV,
        getTopRatedTV: mockGetTopRatedTV,
      );

  test('initial state should be empty', () {
    expect(buildCubit().state, const TVListState());
  });

  group('on the air tv', () {
    blocTest<TVListCubit, TVListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTV.execute())
            .thenAnswer((_) async => Right(testTVList));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchOnTheAirTV(),
      expect: () => [
        const TVListState(onTheAirState: RequestState.Loading),
        TVListState(
          onTheAirState: RequestState.Loaded,
          onTheAirTV: testTVList,
        ),
      ],
      verify: (_) => verify(mockGetOnTheAirTV.execute()),
    );

    blocTest<TVListCubit, TVListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetOnTheAirTV.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchOnTheAirTV(),
      expect: () => [
        const TVListState(onTheAirState: RequestState.Loading),
        const TVListState(
          onTheAirState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('popular tv', () {
    blocTest<TVListCubit, TVListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTV.execute())
            .thenAnswer((_) async => Right(testTVList));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchPopularTV(),
      expect: () => [
        const TVListState(popularTVState: RequestState.Loading),
        TVListState(
          popularTVState: RequestState.Loaded,
          popularTV: testTVList,
        ),
      ],
      verify: (_) => verify(mockGetPopularTV.execute()),
    );

    blocTest<TVListCubit, TVListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetPopularTV.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchPopularTV(),
      expect: () => [
        const TVListState(popularTVState: RequestState.Loading),
        const TVListState(
          popularTVState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('top rated tv', () {
    blocTest<TVListCubit, TVListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTV.execute())
            .thenAnswer((_) async => Right(testTVList));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchTopRatedTV(),
      expect: () => [
        const TVListState(topRatedTVState: RequestState.Loading),
        TVListState(
          topRatedTVState: RequestState.Loaded,
          topRatedTV: testTVList,
        ),
      ],
      verify: (_) => verify(mockGetTopRatedTV.execute()),
    );

    blocTest<TVListCubit, TVListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetTopRatedTV.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchTopRatedTV(),
      expect: () => [
        const TVListState(topRatedTVState: RequestState.Loading),
        const TVListState(
          topRatedTVState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
