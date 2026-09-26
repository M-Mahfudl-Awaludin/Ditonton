import 'dart:convert';

import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  test('should be a subclass of TVDetail entity', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_detail.json'));
    // act
    final result = TVDetailResponse.fromJson(jsonMap).toEntity();
    // assert
    expect(result, testTVDetail);
  });
}
