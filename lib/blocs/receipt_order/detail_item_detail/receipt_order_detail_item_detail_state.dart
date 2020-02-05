import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/receipt_order_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptOrderDetailItemDetailState extends BlocState {
  ReceiptOrderDetailItemDetailState({
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

  factory ReceiptOrderDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return ReceiptOrderDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory ReceiptOrderDetailItemDetailState.busy({
    @required Item data,
  }) {
    return ReceiptOrderDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceiptOrderDetailItemDetailState.success({
    @required Item data,
  }) {
    return ReceiptOrderDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory ReceiptOrderDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return ReceiptOrderDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
