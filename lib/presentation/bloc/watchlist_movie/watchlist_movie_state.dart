part of 'watchlist_movie_cubit.dart';

class WatchlistMovieState extends Equatable {
  final RequestState watchlistState;
  final List<Movie> watchlistMovies;
  final String message;

  const WatchlistMovieState({
    this.watchlistState = RequestState.Empty,
    this.watchlistMovies = const [],
    this.message = '',
  });

  WatchlistMovieState copyWith({
    RequestState? watchlistState,
    List<Movie>? watchlistMovies,
    String? message,
  }) {
    return WatchlistMovieState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistState, watchlistMovies, message];
}
