part of 'movie_search_cubit.dart';

class MovieSearchState extends Equatable {
  final RequestState state;
  final List<Movie> searchResult;
  final String message;

  const MovieSearchState({
    this.state = RequestState.Empty,
    this.searchResult = const [],
    this.message = '',
  });

  MovieSearchState copyWith({
    RequestState? state,
    List<Movie>? searchResult,
    String? message,
  }) {
    return MovieSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, searchResult, message];
}
