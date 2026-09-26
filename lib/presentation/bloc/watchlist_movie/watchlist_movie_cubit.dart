import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  WatchlistMovieCubit({required this.getWatchlistMovies})
      : super(const WatchlistMovieState());

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistMovies.execute();
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
          watchlistMovies: data,
        ));
      },
    );
  }
}
