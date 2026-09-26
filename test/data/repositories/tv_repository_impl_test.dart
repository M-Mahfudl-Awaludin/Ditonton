import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTVModel = TVModel(
    backdropPath: '/backdrop.jpg',
    genreIds: [18, 10765],
    id: 1399,
    name: 'Game of Thrones',
    originalName: 'Game of Thrones',
    overview: 'overview',
    popularity: 369.594,
    posterPath: '/poster.jpg',
    firstAirDate: '2011-04-17',
    voteAverage: 8.3,
    voteCount: 11504,
  );

  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTVModel.toEntity()];

  group('On The Air TV', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getOnTheAirTV())
          .thenAnswer((_) async => tTVModelList);
      final result = await repository.getOnTheAirTV();
      verify(mockRemoteDataSource.getOnTheAirTV());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getOnTheAirTV()).thenThrow(ServerException());
      final result = await repository.getOnTheAirTV();
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device has no internet connection',
        () async {
      when(mockRemoteDataSource.getOnTheAirTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getOnTheAirTV();
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV', () {
    test('should return tv list when call to data source is success',
        () async {
      when(mockRemoteDataSource.getPopularTV())
          .thenAnswer((_) async => tTVModelList);
      final result = await repository.getPopularTV();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return server failure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularTV()).thenThrow(ServerException());
      final result = await repository.getPopularTV();
      expect(result, Left(ServerFailure('')));
    });

    test('should return connection failure when device has no internet',
        () async {
      when(mockRemoteDataSource.getPopularTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getPopularTV();
      expect(result,
          Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV', () {
    test('should return tv list when call to data source is success',
        () async {
      when(mockRemoteDataSource.getTopRatedTV())
          .thenAnswer((_) async => tTVModelList);
      final result = await repository.getTopRatedTV();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return server failure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
      final result = await repository.getTopRatedTV();
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Get TV Detail', () {
    final tId = 1399;

    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenAnswer((_) async => testTVDetailResponse);
      final result = await repository.getTVDetail(tId);
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Right(testTVDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(ServerException());
      final result = await repository.getTVDetail(tId);
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('Get TV Recommendations', () {
    final tId = 1399;

    test('should return data (tv list) when the call is successful', () async {
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenAnswer((_) async => tTVModelList);
      final result = await repository.getTVRecommendations(tId);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return server failure when call is unsuccessful', () async {
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(ServerException());
      final result = await repository.getTVRecommendations(tId);
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('Seach TV', () {
    final tQuery = 'Game of Thrones';

    test('should return tv list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenAnswer((_) async => tTVModelList);
      final result = await repository.searchTV(tQuery);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchTV(tQuery)).thenThrow(ServerException());
      final result = await repository.searchTV(tQuery);
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Get TV Season Detail', () {
    final tId = 1399;
    final tSeasonNumber = 1;

    test(
        'should return season detail when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getTVSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => testTVSeasonDetailResponse);
      final result = await repository.getTVSeasonDetail(tId, tSeasonNumber);
      expect(result, equals(Right(testTVSeasonDetail)));
    });

    test('should return server failure when call is unsuccessful', () async {
      when(mockRemoteDataSource.getTVSeasonDetail(tId, tSeasonNumber))
          .thenThrow(ServerException());
      final result = await repository.getTVSeasonDetail(tId, tSeasonNumber);
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockLocalDataSource.insertWatchlist(testTVTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      final result = await repository.saveWatchlist(testTVDetail);
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.insertWatchlist(testTVTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      final result = await repository.saveWatchlist(testTVDetail);
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockLocalDataSource.removeWatchlist(testTVTable))
          .thenAnswer((_) async => 'Removed from Watchlist');
      final result = await repository.removeWatchlist(testTVDetail);
      expect(result, Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockLocalDataSource.removeWatchlist(testTVTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      final result = await repository.removeWatchlist(testTVDetail);
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      final tId = 1;
      when(mockLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      final result = await repository.isAddedToWatchlist(tId);
      expect(result, false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TV', () async {
      when(mockLocalDataSource.getWatchlistTV())
          .thenAnswer((_) async => [testTVTable]);
      final result = await repository.getWatchlistTV();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });
  });
}
