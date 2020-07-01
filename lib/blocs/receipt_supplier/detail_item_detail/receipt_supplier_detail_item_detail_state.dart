import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_supplier_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptSupplierDetailItemDetailState extends BlocState {
  ReceiptSupplierDetailItemDetailState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.errorMessage: '',
  });

  final Item data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  factory ReceiptSupplierDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return ReceiptSupplierDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory ReceiptSupplierDetailItemDetailState.busy({
    @required Item data,
  }) {
    return ReceiptSupplierDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceiptSupplierDetailItemDetailState.success({
    @required Item data,
  }) {
    return ReceiptSupplierDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory ReceiptSupplierDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return ReceiptSupplierDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
