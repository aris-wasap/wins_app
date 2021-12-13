import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_supplier_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptSupplierDetailState extends BlocState {
  ReceiptSupplierDetailState({
    @required this.data,
    this.newItem,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.succesMessage: '',
    this.errorMessage: '',
  });

  final Data data;
  final Item newItem;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String succesMessage;
  final String errorMessage;

  factory ReceiptSupplierDetailState.noAction() {
    return ReceiptSupplierDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory ReceiptSupplierDetailState.busy({
    @required Data data,
  }) {
    return ReceiptSupplierDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceiptSupplierDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return ReceiptSupplierDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory ReceiptSupplierDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return ReceiptSupplierDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
