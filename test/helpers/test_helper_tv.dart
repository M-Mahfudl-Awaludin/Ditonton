import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';

// Run `flutter pub run build_runner build` to (re)generate
// test_helper_tv.mocks.dart automatically. A hand-written, drop-in
// compatible version of that generated file is already provided in
// test_helper_tv.mocks.dart so the test-suite runs without build_runner.
@GenerateMocks([
  TVRepository,
  TVRemoteDataSource,
  TVLocalDataSource,
])
void main() {}
