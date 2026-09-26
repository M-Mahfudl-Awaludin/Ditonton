import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

  test('should be a subclass of TV entity', () async {
    final result = tTVModel.toEntity();
    expect(result, tTV);
  });
}
