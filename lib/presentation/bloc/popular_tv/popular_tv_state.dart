part of 'popular_tv_cubit.dart';

class PopularTVState extends Equatable {
  final RequestState state;
  final List<TV> tv;
  final String message;

  const PopularTVState({
    this.state = RequestState.Empty,
    this.tv = const [],
    this.message = '',
  });

  PopularTVState copyWith({
    RequestState? state,
    List<TV>? tv,
    String? message,
  }) {
    return PopularTVState(
      state: state ?? this.state,
      tv: tv ?? this.tv,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, tv, message];
}
