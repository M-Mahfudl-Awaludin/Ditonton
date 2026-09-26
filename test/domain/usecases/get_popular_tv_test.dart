import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetPopularTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetPopularTV(mockTVRepository);
  });

  test('should get list of popular tv from the repository', () async {
    // arrange
    when(mockTVRepository.getPopularTV())
        .thenAnswer((_) async => Right(testTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVList));
  });
}
