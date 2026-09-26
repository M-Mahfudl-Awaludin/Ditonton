import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_list_state.dart';

class TVListCubit extends Cubit<TVListState> {
  TVListCubit({
    required this.getOnTheAirTV,
    required this.getPopularTV,
    required this.getTopRatedTV,
  }) : super(const TVListState());

  final GetOnTheAirTV getOnTheAirTV;
  final GetPopularTV getPopularTV;
  final GetTopRatedTV getTopRatedTV;

  Future<void> fetchOnTheAirTV() async {
    emit(state.copyWith(onTheAirState: RequestState.Loading));

    final result = await getOnTheAirTV.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          onTheAirState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvData) {
        emit(state.copyWith(
          onTheAirState: RequestState.Loaded,
          onTheAirTV: tvData,
        ));
      },
    );
  }

  Future<void> fetchPopularTV() async {
    emit(state.copyWith(popularTVState: RequestState.Loading));

    final result = await getPopularTV.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          popularTVState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvData) {
        emit(state.copyWith(
          popularTVState: RequestState.Loaded,
          popularTV: tvData,
        ));
      },
    );
  }

  Future<void> fetchTopRatedTV() async {
    emit(state.copyWith(topRatedTVState: RequestState.Loading));

    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedTVState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvData) {
        emit(state.copyWith(
          topRatedTVState: RequestState.Loaded,
          topRatedTV: tvData,
        ));
      },
    );
  }
}
