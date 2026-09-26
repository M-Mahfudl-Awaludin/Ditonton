import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTVRecommendations usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVRecommendations(mockTVRepository);
  });

  final tId = 1399;

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTVRepository.getTVRecommendations(tId))
        .thenAnswer((_) async => Right(testTVList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVList));
  });
}
