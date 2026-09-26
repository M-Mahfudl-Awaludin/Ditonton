part of 'tv_detail_cubit.dart';

class TVDetailState extends Equatable {
  final RequestState tvState;
  final TVDetail? tv;
  final RequestState recommendationState;
  final List<TV> tvRecommendations;
  final TVSeasonDetail? seasonDetail;
  final RequestState seasonState;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const TVDetailState({
    this.tvState = RequestState.Empty,
    this.tv,
    this.recommendationState = RequestState.Empty,
    this.tvRecommendations = const [],
    this.seasonDetail,
    this.seasonState = RequestState.Empty,
    this.message = '',
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
  });

  TVDetailState copyWith({
    RequestState? tvState,
    TVDetail? tv,
    RequestState? recommendationState,
    List<TV>? tvRecommendations,
    TVSeasonDetail? seasonDetail,
    RequestState? seasonState,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return TVDetailState(
      tvState: tvState ?? this.tvState,
      tv: tv ?? this.tv,
      recommendationState: recommendationState ?? this.recommendationState,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      seasonDetail: seasonDetail ?? this.seasonDetail,
      seasonState: seasonState ?? this.seasonState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvState,
        tv,
        recommendationState,
        tvRecommendations,
        seasonDetail,
        seasonState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
