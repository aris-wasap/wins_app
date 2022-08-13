import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_mixing_list_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueMixingListState extends BlocState {
  GoodsIssueMixingListState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.isActiveSearch: false,
    this.errorMessage: '',
  });

  final List<Data> data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final bool isActiveSearch;
  final String errorMessage;

  factory GoodsIssueMixingListState.noAction() {
    return GoodsIssueMixingListState(data: List<Data>());
  }

  factory GoodsIssueMixingListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsIssueMixingListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsIssueMixingListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsIssueMixingListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsIssueMixingListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return GoodsIssueMixingListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
