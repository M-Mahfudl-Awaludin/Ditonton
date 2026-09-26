import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    databaseHelper = DatabaseHelper();
    // Start every test with a clean slate so results don't leak
    // between tests or previous runs.
    final db = await databaseHelper.database;
    await db!.delete('watchlist');
    await db.delete('watchlist_tv');
  });

  group('movie watchlist', () {
    test('insertWatchlist should insert a movie and return a row id',
        () async {
      final result = await databaseHelper.insertWatchlist(testMovieTable);

      expect(result, isA<int>());
      expect(result, greaterThan(0));
    });

    test('getMovieById should return the movie map when the movie exists',
        () async {
      await databaseHelper.insertWatchlist(testMovieTable);

      final result = await databaseHelper.getMovieById(testMovieTable.id);

      expect(result, isNotNull);
      expect(result!['id'], testMovieTable.id);
      expect(result['title'], testMovieTable.title);
      expect(result['overview'], testMovieTable.overview);
      expect(result['posterPath'], testMovieTable.posterPath);
    });

    test('getMovieById should return null when the movie does not exist',
        () async {
      final result = await databaseHelper.getMovieById(testMovieTable.id);

      expect(result, isNull);
    });

    test('getWatchlistMovies should return all saved movies', () async {
      await databaseHelper.insertWatchlist(testMovieTable);

      final result = await databaseHelper.getWatchlistMovies();

      expect(result, hasLength(1));
      expect(result.first['id'], testMovieTable.id);
    });

    test('getWatchlistMovies should return an empty list when there is none',
        () async {
      final result = await databaseHelper.getWatchlistMovies();

      expect(result, isEmpty);
    });

    test('removeWatchlist should remove the saved movie', () async {
      await databaseHelper.insertWatchlist(testMovieTable);

      await databaseHelper.removeWatchlist(testMovieTable);
      final result = await databaseHelper.getMovieById(testMovieTable.id);

      expect(result, isNull);
    });
  });

  group('tv watchlist', () {
    test('insertWatchlistTV should insert a tv series and return a row id',
        () async {
      final result = await databaseHelper.insertWatchlistTV(testTVTable);

      expect(result, isA<int>());
      expect(result, greaterThan(0));
    });

    test('getTVById should return the tv map when the tv series exists',
        () async {
      await databaseHelper.insertWatchlistTV(testTVTable);

      final result = await databaseHelper.getTVById(testTVTable.id);

      expect(result, isNotNull);
      expect(result!['id'], testTVTable.id);
      expect(result['name'], testTVTable.name);
      expect(result['overview'], testTVTable.overview);
      expect(result['posterPath'], testTVTable.posterPath);
    });

    test('getTVById should return null when the tv series does not exist',
        () async {
      final result = await databaseHelper.getTVById(testTVTable.id);

      expect(result, isNull);
    });

    test('getWatchlistTV should return all saved tv series', () async {
      await databaseHelper.insertWatchlistTV(testTVTable);

      final result = await databaseHelper.getWatchlistTV();

      expect(result, hasLength(1));
      expect(result.first['id'], testTVTable.id);
    });

    test('getWatchlistTV should return an empty list when there is none',
        () async {
      final result = await databaseHelper.getWatchlistTV();

      expect(result, isEmpty);
    });

    test('removeWatchlistTV should remove the saved tv series', () async {
      await databaseHelper.insertWatchlistTV(testTVTable);

      await databaseHelper.removeWatchlistTV(testTVTable);
      final result = await databaseHelper.getTVById(testTVTable.id);

      expect(result, isNull);
    });
  });

  group('DatabaseHelper singleton', () {
    test('should always return the same instance', () {
      final first = DatabaseHelper();
      final second = DatabaseHelper();

      expect(first, same(second));
    });

    test('database getter should return the same database instance on '
        'repeated access', () async {
      final firstDb = await databaseHelper.database;
      final secondDb = await databaseHelper.database;

      expect(firstDb, same(secondDb));
    });
  });
}
