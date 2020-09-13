import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/payable_credit_detail_response.dart';
import 'package:meta/meta.dart';

class PayableCreditDetailState extends BlocState {
  PayableCreditDetailState({
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

  factory PayableCreditDetailState.noAction() {
    return PayableCreditDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory PayableCreditDetailState.busy({
    @required Data data,
  }) {
    return PayableCreditDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory PayableCreditDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return PayableCreditDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory PayableCreditDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return PayableCreditDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
