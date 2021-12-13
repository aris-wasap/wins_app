import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_production_list_response.dart';
import 'package:meta/meta.dart';

class ReceiptProductionListState extends BlocState {
  ReceiptProductionListState({
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

  factory ReceiptProductionListState.noAction() {
    return ReceiptProductionListState(data: List<Data>());
  }

  factory ReceiptProductionListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptProductionListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptProductionListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptProductionListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptProductionListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return ReceiptProductionListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
