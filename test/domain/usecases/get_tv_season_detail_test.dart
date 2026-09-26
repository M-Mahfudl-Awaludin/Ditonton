import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTVSeasonDetail usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVSeasonDetail(mockTVRepository);
  });

  final tId = 1399;
  final tSeasonNumber = 1;

  test('should get tv season detail from the repository', () async {
    // arrange
    when(mockTVRepository.getTVSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(testTVSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, Right(testTVSeasonDetail));
  });
}
