import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTopRatedTV extends Mock implements GetTopRatedTV {
  @override
  Future<Either<Failure, List<TV>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<Either<Failure, List<TV>>>.value(Right(<TV>[])))
          as Future<Either<Failure, List<TV>>>);
}

void main() {
  late MockGetTopRatedTV mockGetTopRatedTV;

  setUp(() {
    mockGetTopRatedTV = MockGetTopRatedTV();
  });

  test('initial state should be empty', () {
    expect(TopRatedTVCubit(mockGetTopRatedTV).state, const TopRatedTVState());
  });

  blocTest<TopRatedTVCubit, TopRatedTVState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Right(testTVList));
      return TopRatedTVCubit(mockGetTopRatedTV);
    },
    act: (cubit) => cubit.fetchTopRatedTV(),
    expect: () => [
      const TopRatedTVState(state: RequestState.Loading),
      TopRatedTVState(state: RequestState.Loaded, tv: testTVList),
    ],
    verify: (_) => verify(mockGetTopRatedTV.execute()),
  );

  blocTest<TopRatedTVCubit, TopRatedTVState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return TopRatedTVCubit(mockGetTopRatedTV);
    },
    act: (cubit) => cubit.fetchTopRatedTV(),
    expect: () => [
      const TopRatedTVState(state: RequestState.Loading),
      const TopRatedTVState(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
