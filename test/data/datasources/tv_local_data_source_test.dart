import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist tv', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelper.insertWatchlistTV(testTVTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.insertWatchlist(testTVTable);
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDatabaseHelper.insertWatchlistTV(testTVTable))
          .thenThrow(Exception());
      final call = dataSource.insertWatchlist(testTVTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist tv', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeWatchlistTV(testTVTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.removeWatchlist(testTVTable);
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockDatabaseHelper.removeWatchlistTV(testTVTable))
          .thenThrow(Exception());
      final call = dataSource.removeWatchlist(testTVTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV By Id', () {
    final tId = 1399;

    test('should return TV Table when data is found', () async {
      when(mockDatabaseHelper.getTVById(tId))
          .thenAnswer((_) async => testTVMap);
      final result = await dataSource.getTVById(tId);
      expect(result, testTVTable);
    });

    test('should return null when data is not found', () async {
      when(mockDatabaseHelper.getTVById(tId)).thenAnswer((_) async => null);
      final result = await dataSource.getTVById(tId);
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TVTable from database', () async {
      when(mockDatabaseHelper.getWatchlistTV())
          .thenAnswer((_) async => [testTVMap]);
      final result = await dataSource.getWatchlistTV();
      expect(result, [testTVTable]);
    });
  });
}
