import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tv_state.dart';

class TopRatedTVCubit extends Cubit<TopRatedTVState> {
  TopRatedTVCubit(this.getTopRatedTV) : super(const TopRatedTVState());

  final GetTopRatedTV getTopRatedTV;

  Future<void> fetchTopRatedTV() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getTopRatedTV.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvData) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          tv: tvData,
        ));
      },
    );
  }
}
