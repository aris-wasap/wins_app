import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_receipt_list_response.dart';
import 'package:meta/meta.dart';

class GoodsReceiptWOListState extends BlocState {
  GoodsReceiptWOListState({
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

  factory GoodsReceiptWOListState.noAction() {
    return GoodsReceiptWOListState(data: List<Data>());
  }

  factory GoodsReceiptWOListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsReceiptWOListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsReceiptWOListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsReceiptWOListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsReceiptWOListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return GoodsReceiptWOListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
