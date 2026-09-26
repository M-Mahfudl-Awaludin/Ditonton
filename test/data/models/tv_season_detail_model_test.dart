import 'dart:convert';

import 'package:ditonton/data/models/tv_season_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  test('should be a subclass of TVSeasonDetail entity', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_season_detail.json'));
    // act
    final result = TVSeasonDetailResponse.fromJson(jsonMap).toEntity();
    // assert
    expect(result, testTVSeasonDetail);
  });
}
