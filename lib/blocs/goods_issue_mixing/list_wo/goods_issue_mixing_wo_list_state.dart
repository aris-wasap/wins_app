import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_mixing_list_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueMixingWOListState extends BlocState {
  GoodsIssueMixingWOListState({
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

  factory GoodsIssueMixingWOListState.noAction() {
    return GoodsIssueMixingWOListState(data: List<Data>());
  }

  factory GoodsIssueMixingWOListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsIssueMixingWOListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsIssueMixingWOListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsIssueMixingWOListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsIssueMixingWOListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return GoodsIssueMixingWOListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
