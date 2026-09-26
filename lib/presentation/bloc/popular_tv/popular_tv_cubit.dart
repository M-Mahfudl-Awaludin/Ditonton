import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_state.dart';

class PopularTVCubit extends Cubit<PopularTVState> {
  PopularTVCubit(this.getPopularTV) : super(const PopularTVState());

  final GetPopularTV getPopularTV;

  Future<void> fetchPopularTV() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getPopularTV.execute();

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
