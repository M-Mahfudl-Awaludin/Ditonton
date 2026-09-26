import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_state.dart';

class WatchlistTVCubit extends Cubit<WatchlistTVState> {
  WatchlistTVCubit({required this.getWatchlistTV})
      : super(const WatchlistTVState());

  final GetWatchlistTV getWatchlistTV;

  Future<void> fetchWatchlistTV() async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistTV.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          watchlistState: RequestState.Loaded,
          watchlistTV: data,
        ));
      },
    );
  }
}
