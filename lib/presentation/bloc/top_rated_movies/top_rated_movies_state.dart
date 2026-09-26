part of 'top_rated_movies_cubit.dart';

class TopRatedMoviesState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const TopRatedMoviesState({
    this.state = RequestState.Empty,
    this.movies = const [],
    this.message = '',
  });

  TopRatedMoviesState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return TopRatedMoviesState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, movies, message];
}
