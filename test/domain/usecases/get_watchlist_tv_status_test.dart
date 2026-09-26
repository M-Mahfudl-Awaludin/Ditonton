import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetWatchListTVStatus usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchListTVStatus(mockTVRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTVRepository.isAddedToWatchlist(1399))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1399);
    // assert
    expect(result, true);
  });
}
