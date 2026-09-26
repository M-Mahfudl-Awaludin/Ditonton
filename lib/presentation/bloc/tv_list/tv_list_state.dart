part of 'tv_list_cubit.dart';

class TVListState extends Equatable {
  final RequestState onTheAirState;
  final List<TV> onTheAirTV;
  final RequestState popularTVState;
  final List<TV> popularTV;
  final RequestState topRatedTVState;
  final List<TV> topRatedTV;
  final String message;

  const TVListState({
    this.onTheAirState = RequestState.Empty,
    this.onTheAirTV = const [],
    this.popularTVState = RequestState.Empty,
    this.popularTV = const [],
    this.topRatedTVState = RequestState.Empty,
    this.topRatedTV = const [],
    this.message = '',
  });

  TVListState copyWith({
    RequestState? onTheAirState,
    List<TV>? onTheAirTV,
    RequestState? popularTVState,
    List<TV>? popularTV,
    RequestState? topRatedTVState,
    List<TV>? topRatedTV,
    String? message,
  }) {
    return TVListState(
      onTheAirState: onTheAirState ?? this.onTheAirState,
      onTheAirTV: onTheAirTV ?? this.onTheAirTV,
      popularTVState: popularTVState ?? this.popularTVState,
      popularTV: popularTV ?? this.popularTV,
      topRatedTVState: topRatedTVState ?? this.topRatedTVState,
      topRatedTV: topRatedTV ?? this.topRatedTV,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        onTheAirState,
        onTheAirTV,
        popularTVState,
        popularTV,
        topRatedTVState,
        topRatedTV,
        message,
      ];
}
