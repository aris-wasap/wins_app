import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_order_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptOrderDetailState extends BlocState {
  ReceiptOrderDetailState({
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

  factory ReceiptOrderDetailState.noAction() {
    return ReceiptOrderDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory ReceiptOrderDetailState.busy({
    @required Data data,
  }) {
    return ReceiptOrderDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory ReceiptOrderDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return ReceiptOrderDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory ReceiptOrderDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return ReceiptOrderDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
