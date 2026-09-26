import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetPopularTV extends Mock implements GetPopularTV {
  @override
  Future<Either<Failure, List<TV>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<Either<Failure, List<TV>>>.value(Right(<TV>[])))
          as Future<Either<Failure, List<TV>>>);
}

void main() {
  late MockGetPopularTV mockGetPopularTV;

  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
  });

  test('initial state should be empty', () {
    expect(PopularTVCubit(mockGetPopularTV).state, const PopularTVState());
  });

  blocTest<PopularTVCubit, PopularTVState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right(testTVList));
      return PopularTVCubit(mockGetPopularTV);
    },
    act: (cubit) => cubit.fetchPopularTV(),
    expect: () => [
      const PopularTVState(state: RequestState.Loading),
      PopularTVState(state: RequestState.Loaded, tv: testTVList),
    ],
    verify: (_) => verify(mockGetPopularTV.execute()),
  );

  blocTest<PopularTVCubit, PopularTVState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return PopularTVCubit(mockGetPopularTV);
    },
    act: (cubit) => cubit.fetchPopularTV(),
    expect: () => [
      const PopularTVState(state: RequestState.Loading),
      const PopularTVState(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
