part of 'top_rated_tv_cubit.dart';

class TopRatedTVState extends Equatable {
  final RequestState state;
  final List<TV> tv;
  final String message;

  const TopRatedTVState({
    this.state = RequestState.Empty,
    this.tv = const [],
    this.message = '',
  });

  TopRatedTVState copyWith({
    RequestState? state,
    List<TV>? tv,
    String? message,
  }) {
    return TopRatedTVState(
      state: state ?? this.state,
      tv: tv ?? this.tv,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, tv, message];
}
