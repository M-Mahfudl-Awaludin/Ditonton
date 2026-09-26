import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_search_state.dart';

class TVSearchCubit extends Cubit<TVSearchState> {
  TVSearchCubit({required this.searchTV}) : super(const TVSearchState());

  final SearchTV searchTV;

  Future<void> fetchTVSearch(String query) async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await searchTV.execute(query);
    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          searchResult: data,
        ));
      },
    );
  }
}
