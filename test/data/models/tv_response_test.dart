import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVModel = TVModel(
    backdropPath: "/backdrop.jpg",
    genreIds: [18, 10765],
    id: 1399,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros.",
    popularity: 369.594,
    posterPath: "/poster.jpg",
    firstAirDate: "2011-04-17",
    voteAverage: 8.3,
    voteCount: 11504,
  );
  final tTVResponseModel = TVResponse(tvList: <TVModel>[tTVModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/popular_tv.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/backdrop.jpg",
            "genre_ids": [18, 10765],
            "id": 1399,
            "name": "Game of Thrones",
            "original_name": "Game of Thrones",
            "overview":
                "Seven noble families fight for control of the mythical land of Westeros.",
            "popularity": 369.594,
            "poster_path": "/poster.jpg",
            "first_air_date": "2011-04-17",
            "vote_average": 8.3,
            "vote_count": 11504,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
