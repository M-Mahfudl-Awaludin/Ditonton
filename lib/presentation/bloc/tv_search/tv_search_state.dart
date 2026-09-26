part of 'tv_search_cubit.dart';

class TVSearchState extends Equatable {
  final RequestState state;
  final List<TV> searchResult;
  final String message;

  const TVSearchState({
    this.state = RequestState.Empty,
    this.searchResult = const [],
    this.message = '',
  });

  TVSearchState copyWith({
    RequestState? state,
    List<TV>? searchResult,
    String? message,
  }) {
    return TVSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, searchResult, message];
}
