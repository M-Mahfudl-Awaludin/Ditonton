import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTVDetail extends Mock implements GetTVDetail {
  @override
  Future<Either<Failure, TVDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<Either<Failure, TVDetail>>.value(
                  Right(testTVDetail)))
          as Future<Either<Failure, TVDetail>>);
}

class MockGetTVRecommendations extends Mock implements GetTVRecommendations {
  @override
  Future<Either<Failure, List<TV>>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue:
                  Future<Either<Failure, List<TV>>>.value(Right(<TV>[])))
          as Future<Either<Failure, List<TV>>>);
}

class MockGetTVSeasonDetail extends Mock implements GetTVSeasonDetail {
  @override
  Future<Either<Failure, TVSeasonDetail>> execute(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#execute, [id, seasonNumber]),
              returnValue: Future<Either<Failure, TVSeasonDetail>>.value(
                  Right(testTVSeasonDetail)))
          as Future<Either<Failure, TVSeasonDetail>>);
}

class MockGetWatchListTVStatus extends Mock implements GetWatchListTVStatus {
  @override
  Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as Future<bool>);
}

class MockSaveWatchlistTV extends Mock implements SaveWatchlistTV {
  @override
  Future<Either<Failure, String>> execute(TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue:
                  Future<Either<Failure, String>>.value(Right('')))
          as Future<Either<Failure, String>>);
}

class MockRemoveWatchlistTV extends Mock implements RemoveWatchlistTV {
  @override
  Future<Either<Failure, String>> execute(TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue:
                  Future<Either<Failure, String>>.value(Right('')))
          as Future<Either<Failure, String>>);
}

void main() {
  late TVDetailCubit cubit;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetTVSeasonDetail mockGetTVSeasonDetail;
  late MockGetWatchListTVStatus mockGetWatchListTVStatus;
  late MockSaveWatchlistTV mockSaveWatchlistTV;
  late MockRemoveWatchlistTV mockRemoveWatchlistTV;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetTVSeasonDetail = MockGetTVSeasonDetail();
    mockGetWatchListTVStatus = MockGetWatchListTVStatus();
    mockSaveWatchlistTV = MockSaveWatchlistTV();
    mockRemoveWatchlistTV = MockRemoveWatchlistTV();
    cubit = TVDetailCubit(
      getTVDetail: mockGetTVDetail,
      getTVRecommendations: mockGetTVRecommendations,
      getTVSeasonDetail: mockGetTVSeasonDetail,
      getWatchListTVStatus: mockGetWatchListTVStatus,
      saveWatchlistTV: mockSaveWatchlistTV,
      removeWatchlistTV: mockRemoveWatchlistTV,
    );
  });

  final tId = 1399;
  final tTV = TV(
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
  final tTVs = <TV>[tTV];

  void _arrangeUsecase() {
    when(mockGetTVDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVDetail));
    when(mockGetTVRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTVs));
  }

  group('Get TV Detail', () {
    test('should get data from the usecase', () async {
      _arrangeUsecase();
      await cubit.fetchTVDetail(tId);
      verify(mockGetTVDetail.execute(tId));
      verify(mockGetTVRecommendations.execute(tId));
    });

    test('should change tv when data is gotten successfully', () async {
      _arrangeUsecase();
      await cubit.fetchTVDetail(tId);
      expect(cubit.state.tvState, RequestState.Loaded);
      expect(cubit.state.tv, testTVDetail);
    });

    test('should change recommendation tv when data is gotten successfully',
        () async {
      _arrangeUsecase();
      await cubit.fetchTVDetail(tId);
      expect(cubit.state.recommendationState, RequestState.Loaded);
      expect(cubit.state.tvRecommendations, tTVs);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVs));
      await cubit.fetchTVDetail(tId);
      expect(cubit.state.tvState, RequestState.Error);
      expect(cubit.state.message, 'Server Failure');
    });
  });

  group('Get TV Season Detail', () {
    test('should get season detail data from the usecase', () async {
      when(mockGetTVSeasonDetail.execute(tId, 1))
          .thenAnswer((_) async => Right(testTVSeasonDetail));
      await cubit.fetchSeasonDetail(tId, 1);
      expect(cubit.state.seasonState, RequestState.Loaded);
      expect(cubit.state.seasonDetail, testTVSeasonDetail);
    });

    test('should return error when season data is unsuccessful', () async {
      when(mockGetTVSeasonDetail.execute(tId, 1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      await cubit.fetchSeasonDetail(tId, 1);
      expect(cubit.state.seasonState, RequestState.Error);
      expect(cubit.state.message, 'Server Failure');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      when(mockGetWatchListTVStatus.execute(1)).thenAnswer((_) async => true);
      await cubit.loadWatchlistStatus(1);
      expect(cubit.state.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      when(mockSaveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListTVStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      await cubit.addWatchlist(testTVDetail);
      verify(mockSaveWatchlistTV.execute(testTVDetail));
    });

    test('should execute remove watchlist when function called', () async {
      when(mockRemoveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      when(mockGetWatchListTVStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      await cubit.removeFromWatchlist(testTVDetail);
      verify(mockRemoveWatchlistTV.execute(testTVDetail));
    });

    test('should update watchlist status when add watchlist success',
        () async {
      when(mockSaveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListTVStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      await cubit.addWatchlist(testTVDetail);
      expect(cubit.state.watchlistMessage, 'Added to Watchlist');
    });

    test('should update watchlist message when add watchlist failed',
        () async {
      when(mockSaveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListTVStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      await cubit.addWatchlist(testTVDetail);
      expect(cubit.state.watchlistMessage, 'Failed');
    });
  });
}
