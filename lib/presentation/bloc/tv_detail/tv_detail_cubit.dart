import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_state.dart';

class TVDetailCubit extends Cubit<TVDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetTVSeasonDetail getTVSeasonDetail;
  final GetWatchListTVStatus getWatchListTVStatus;
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTV removeWatchlistTV;

  TVDetailCubit({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getTVSeasonDetail,
    required this.getWatchListTVStatus,
    required this.saveWatchlistTV,
    required this.removeWatchlistTV,
  }) : super(const TVDetailState());

  Future<void> fetchTVDetail(int id) async {
    emit(state.copyWith(tvState: RequestState.Loading));

    final detailResult = await getTVDetail.execute(id);
    final recommendationResult = await getTVRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          tvState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tv) {
        emit(state.copyWith(
          recommendationState: RequestState.Loading,
          tv: tv,
        ));

        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
              recommendationState: RequestState.Error,
              message: failure.message,
            ));
          },
          (tvList) {
            emit(state.copyWith(
              recommendationState: RequestState.Loaded,
              tvRecommendations: tvList,
            ));
          },
        );

        emit(state.copyWith(tvState: RequestState.Loaded));
      },
    );
  }

  Future<void> fetchSeasonDetail(int id, int seasonNumber) async {
    emit(state.copyWith(seasonState: RequestState.Loading));

    final result = await getTVSeasonDetail.execute(id, seasonNumber);
    result.fold(
      (failure) {
        emit(state.copyWith(
          seasonState: RequestState.Error,
          message: failure.message,
        ));
      },
      (season) {
        emit(state.copyWith(
          seasonState: RequestState.Loaded,
          seasonDetail: season,
        ));
      },
    );
  }

  Future<void> addWatchlist(TVDetail tv) async {
    final result = await saveWatchlistTV.execute(tv);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TVDetail tv) async {
    final result = await removeWatchlistTV.execute(tv);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListTVStatus.execute(id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
