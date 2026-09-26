part of 'watchlist_tv_cubit.dart';

class WatchlistTVState extends Equatable {
  final RequestState watchlistState;
  final List<TV> watchlistTV;
  final String message;

  const WatchlistTVState({
    this.watchlistState = RequestState.Empty,
    this.watchlistTV = const [],
    this.message = '',
  });

  WatchlistTVState copyWith({
    RequestState? watchlistState,
    List<TV>? watchlistTV,
    String? message,
  }) {
    return WatchlistTVState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistTV: watchlistTV ?? this.watchlistTV,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistState, watchlistTV, message];
}
