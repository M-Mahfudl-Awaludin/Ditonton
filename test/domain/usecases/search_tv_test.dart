import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late SearchTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTV(mockTVRepository);
  });

  final tTVList = <TV>[];
  final tQuery = 'Game of Thrones';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.searchTV(tQuery))
        .thenAnswer((_) async => Right(tTVList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTVList));
  });
}
