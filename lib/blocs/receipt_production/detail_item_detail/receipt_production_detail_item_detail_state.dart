import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_production_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptProductionDetailItemDetailState extends BlocState {
  ReceiptProductionDetailItemDetailState({
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

  factory ReceiptProductionDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return ReceiptProductionDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory ReceiptProductionDetailItemDetailState.busy({
    @required Item data,
  }) {
    return ReceiptProductionDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceiptProductionDetailItemDetailState.success({
    @required Item data,
  }) {
    return ReceiptProductionDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory ReceiptProductionDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return ReceiptProductionDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
