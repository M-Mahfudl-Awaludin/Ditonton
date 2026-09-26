import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetWatchlistTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchlistTV(mockTVRepository);
  });

  test('should get list of watchlist tv from the repository', () async {
    // arrange
    final tWatchlistTVList = <TV>[testWatchlistTV];
    when(mockTVRepository.getWatchlistTV())
        .thenAnswer((_) async => Right(tWatchlistTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tWatchlistTVList));
  });
}
