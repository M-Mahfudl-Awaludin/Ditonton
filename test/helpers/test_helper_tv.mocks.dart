// Hand-written mocks (drop-in compatible with mockito's generated output)
// for TVRepository, TVRemoteDataSource, and TVLocalDataSource.
// If you run `flutter pub run build_runner build`, this file can be
// regenerated automatically from test_helper_tv.dart.

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_season_detail_model.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:mockito/mockito.dart';

class _FakeEither<L, R> extends Fake implements Either<L, R> {}

class _FakeTVDetailResponse extends Fake implements TVDetailResponse {}

class _FakeTVSeasonDetailResponse extends Fake
    implements TVSeasonDetailResponse {}

/// A class which mocks [TVRepository].
class MockTVRepository extends Mock implements TVRepository {
  MockTVRepository() {
    throwOnMissingStub(this);
  }

  @override
  Future<Either<Failure, List<TV>>> getOnTheAirTV() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTV, []),
          returnValue: Future<Either<Failure, List<TV>>>.value(
              _FakeEither<Failure, List<TV>>())) as Future<Either<Failure, List<TV>>>);

  @override
  Future<Either<Failure, List<TV>>> getPopularTV() =>
      (super.noSuchMethod(Invocation.method(#getPopularTV, []),
          returnValue: Future<Either<Failure, List<TV>>>.value(
              _FakeEither<Failure, List<TV>>())) as Future<Either<Failure, List<TV>>>);

  @override
  Future<Either<Failure, List<TV>>> getTopRatedTV() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTV, []),
          returnValue: Future<Either<Failure, List<TV>>>.value(
              _FakeEither<Failure, List<TV>>())) as Future<Either<Failure, List<TV>>>);

  @override
  Future<Either<Failure, TVDetail>> getTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVDetail, [id]),
              returnValue: Future<Either<Failure, TVDetail>>.value(
                  _FakeEither<Failure, TVDetail>()))
          as Future<Either<Failure, TVDetail>>);

  @override
  Future<Either<Failure, List<TV>>> getTVRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVRecommendations, [id]),
              returnValue: Future<Either<Failure, List<TV>>>.value(
                  _FakeEither<Failure, List<TV>>()))
          as Future<Either<Failure, List<TV>>>);

  @override
  Future<Either<Failure, List<TV>>> searchTV(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTV, [query]),
              returnValue: Future<Either<Failure, List<TV>>>.value(
                  _FakeEither<Failure, List<TV>>()))
          as Future<Either<Failure, List<TV>>>);

  @override
  Future<Either<Failure, TVSeasonDetail>> getTVSeasonDetail(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTVSeasonDetail, [id, seasonNumber]),
              returnValue: Future<Either<Failure, TVSeasonDetail>>.value(
                  _FakeEither<Failure, TVSeasonDetail>()))
          as Future<Either<Failure, TVSeasonDetail>>);

  @override
  Future<Either<Failure, String>> saveWatchlist(TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tv]),
              returnValue: Future<Either<Failure, String>>.value(
                  _FakeEither<Failure, String>()))
          as Future<Either<Failure, String>>);

  @override
  Future<Either<Failure, String>> removeWatchlist(TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
              returnValue: Future<Either<Failure, String>>.value(
                  _FakeEither<Failure, String>()))
          as Future<Either<Failure, String>>);

  @override
  Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as Future<bool>);

  @override
  Future<Either<Failure, List<TV>>> getWatchlistTV() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTV, []),
          returnValue: Future<Either<Failure, List<TV>>>.value(
              _FakeEither<Failure, List<TV>>())) as Future<Either<Failure, List<TV>>>);
}

/// A class which mocks [TVRemoteDataSource].
class MockTVRemoteDataSource extends Mock implements TVRemoteDataSource {
  @override
  Future<List<TVModel>> getOnTheAirTV() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTV, []),
          returnValue: Future<List<TVModel>>.value(<TVModel>[]))
          as Future<List<TVModel>>);

  @override
  Future<List<TVModel>> getPopularTV() =>
      (super.noSuchMethod(Invocation.method(#getPopularTV, []),
          returnValue: Future<List<TVModel>>.value(<TVModel>[]))
          as Future<List<TVModel>>);

  @override
  Future<List<TVModel>> getTopRatedTV() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTV, []),
          returnValue: Future<List<TVModel>>.value(<TVModel>[]))
          as Future<List<TVModel>>);

  @override
  Future<TVDetailResponse> getTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVDetail, [id]),
              returnValue:
                  Future<TVDetailResponse>.value(_FakeTVDetailResponse()))
          as Future<TVDetailResponse>);

  @override
  Future<List<TVModel>> getTVRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVRecommendations, [id]),
          returnValue: Future<List<TVModel>>.value(<TVModel>[]))
          as Future<List<TVModel>>);

  @override
  Future<List<TVModel>> searchTV(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTV, [query]),
          returnValue: Future<List<TVModel>>.value(<TVModel>[]))
          as Future<List<TVModel>>);

  @override
  Future<TVSeasonDetailResponse> getTVSeasonDetail(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTVSeasonDetail, [id, seasonNumber]),
              returnValue: Future<TVSeasonDetailResponse>.value(
                  _FakeTVSeasonDetailResponse()))
          as Future<TVSeasonDetailResponse>);
}

/// A class which mocks [TVLocalDataSource].
class MockTVLocalDataSource extends Mock implements TVLocalDataSource {
  @override
  Future<String> insertWatchlist(TVTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tv]),
          returnValue: Future<String>.value('')) as Future<String>);

  @override
  Future<String> removeWatchlist(TVTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
          returnValue: Future<String>.value('')) as Future<String>);

  @override
  Future<TVTable?> getTVById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVById, [id]),
          returnValue: Future<TVTable?>.value()) as Future<TVTable?>);

  @override
  Future<List<TVTable>> getWatchlistTV() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTV, []),
          returnValue: Future<List<TVTable>>.value(<TVTable>[]))
          as Future<List<TVTable>>);
}
