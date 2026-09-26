import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_season_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/on_the_air_tv.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air_tv.json'), 200));
      final result = await dataSource.getOnTheAirTV();
      expect(result, equals(tTVList));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getOnTheAirTV();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));
      final result = await dataSource.getPopularTV();
      expect(result, equals(tTVList));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getPopularTV();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
      final result = await dataSource.getTopRatedTV();
      expect(result, equals(tTVList));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTopRatedTV();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1399;

    test('should return tv detail when the response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      final result = await dataSource.getTVDetail(tId);
      expect(result, isA<TVDetailResponse>());
    });

    test('should throw Server Exception when the response code is not 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTVDetail(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 1399;

    test('should return list of TV Model when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
      final result = await dataSource.getTVRecommendations(tId);
      expect(result, equals(tTVList));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTVRecommendations(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tQuery = 'Game of Thrones';
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/search_got_tv.json')))
        .tvList;

    test('should return list of tv when response code is 200', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/search_got_tv.json'), 200));
      final result = await dataSource.searchTV(tQuery);
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.searchTV(tQuery);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv season detail', () {
    final tId = 1399;
    final tSeasonNumber = 1;

    test('should return tv season detail when the response code is 200',
        () async {
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$tSeasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_season_detail.json'), 200));
      final result = await dataSource.getTVSeasonDetail(tId, tSeasonNumber);
      expect(result, isA<TVSeasonDetailResponse>());
    });

    test('should throw Server Exception when the response code is not 200',
        () async {
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$tSeasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTVSeasonDetail(tId, tSeasonNumber);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
