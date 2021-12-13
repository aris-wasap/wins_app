import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_order_list_response.dart';
import 'package:meta/meta.dart';

class ReceiptOrderListState extends BlocState {
  ReceiptOrderListState({
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

  factory ReceiptOrderListState.noAction() {
    return ReceiptOrderListState(data: List<Data>());
  }

  factory ReceiptOrderListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptOrderListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptOrderListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptOrderListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptOrderListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return ReceiptOrderListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
