import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_production_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptProductionDetailState extends BlocState {
  ReceiptProductionDetailState({
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

  factory ReceiptProductionDetailState.noAction() {
    return ReceiptProductionDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory ReceiptProductionDetailState.busy({
    @required Data data,
  }) {
    return ReceiptProductionDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceiptProductionDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return ReceiptProductionDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory ReceiptProductionDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return ReceiptProductionDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
