import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit(this.getPopularMovies)
      : super(const PopularMoviesState());

  final GetPopularMovies getPopularMovies;

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          movies: moviesData,
        ));
      },
    );
  }
}
