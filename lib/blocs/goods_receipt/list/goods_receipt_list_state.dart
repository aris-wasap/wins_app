import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_receipt_list_response.dart';
import 'package:meta/meta.dart';

class GoodsReceiptListState extends BlocState {
  GoodsReceiptListState({
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

  factory GoodsReceiptListState.noAction() {
    return GoodsReceiptListState(data: List<Data>());
  }

  factory GoodsReceiptListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsReceiptListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsReceiptListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsReceiptListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsReceiptListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return GoodsReceiptListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
