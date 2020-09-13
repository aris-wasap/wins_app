import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receivable_credit_detail_response.dart';
import 'package:meta/meta.dart';

class ReceivableCreditDetailState extends BlocState {
  ReceivableCreditDetailState({
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

  factory ReceivableCreditDetailState.noAction() {
    return ReceivableCreditDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory ReceivableCreditDetailState.busy({
    @required Data data,
  }) {
    return ReceivableCreditDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory ReceivableCreditDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return ReceivableCreditDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory ReceivableCreditDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return ReceivableCreditDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
