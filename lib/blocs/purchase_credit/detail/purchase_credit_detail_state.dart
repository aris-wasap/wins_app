import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/purchase_credit_detail_response.dart';
import 'package:meta/meta.dart';

class PurchaseCreditDetailState extends BlocState {
  PurchaseCreditDetailState({
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

  factory PurchaseCreditDetailState.noAction() {
    return PurchaseCreditDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory PurchaseCreditDetailState.busy({
    @required Data data,
  }) {
    return PurchaseCreditDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory PurchaseCreditDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return PurchaseCreditDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory PurchaseCreditDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return PurchaseCreditDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
