import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockSearchTV extends Mock implements SearchTV {
  @override
  Future<Either<Failure, List<TV>>> execute(String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
              returnValue:
                  Future<Either<Failure, List<TV>>>.value(Right(<TV>[])))
          as Future<Either<Failure, List<TV>>>);
}

void main() {
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTV();
  });

  final tQuery = 'Game of Thrones';

  test('initial state should be empty', () {
    expect(TVSearchCubit(searchTV: mockSearchTV).state,
        const TVSearchState());
  });

  blocTest<TVSearchCubit, TVSearchState>(
    'should emit [Loading, Loaded] when data is found',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(testTVList));
      return TVSearchCubit(searchTV: mockSearchTV);
    },
    act: (cubit) => cubit.fetchTVSearch(tQuery),
    expect: () => [
      const TVSearchState(state: RequestState.Loading),
      TVSearchState(state: RequestState.Loaded, searchResult: testTVList),
    ],
    verify: (_) => verify(mockSearchTV.execute(tQuery)),
  );

  blocTest<TVSearchCubit, TVSearchState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return TVSearchCubit(searchTV: mockSearchTV);
    },
    act: (cubit) => cubit.fetchTVSearch(tQuery),
    expect: () => [
      const TVSearchState(state: RequestState.Loading),
      const TVSearchState(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
