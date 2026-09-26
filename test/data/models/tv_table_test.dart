import 'package:ditonton/data/models/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a proper model from entity', () async {
    final result = TVTable.fromEntity(testTVDetail);
    expect(result, testTVTable);
  });

  test('should be a proper model from map', () async {
    final result = TVTable.fromMap(testTVMap);
    expect(result, testTVTable);
  });

  test('should return a proper map from entity', () async {
    final result = testTVTable.toJson();
    final expectedMap = {
      'id': 1399,
      'name': 'Game of Thrones',
      'posterPath': 'posterPath',
      'overview': 'overview',
    };
    expect(result, expectedMap);
  });

  test('should be a proper TV entity', () async {
    final result = testTVTable.toEntity();
    expect(result, testWatchlistTV);
  });
}
