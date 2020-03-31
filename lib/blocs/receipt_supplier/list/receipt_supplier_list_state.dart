import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/receipt_supplier_list_response.dart'; 
import 'package:meta/meta.dart';

class ReceiptSupplierListState extends BlocState {
  ReceiptSupplierListState({
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

  factory ReceiptSupplierListState.noAction() {
    return ReceiptSupplierListState(data: List<Data>());
  }

  factory ReceiptSupplierListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptSupplierListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptSupplierListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptSupplierListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptSupplierListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return ReceiptSupplierListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
