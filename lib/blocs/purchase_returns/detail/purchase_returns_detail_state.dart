import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/purchase_returns_detail_response.dart';
import 'package:meta/meta.dart';

class PurchaseReturnsDetailState extends BlocState {
  PurchaseReturnsDetailState({
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

  factory PurchaseReturnsDetailState.noAction() {
    return PurchaseReturnsDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory PurchaseReturnsDetailState.busy({
    @required Data data,
  }) {
    return PurchaseReturnsDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory PurchaseReturnsDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return PurchaseReturnsDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory PurchaseReturnsDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return PurchaseReturnsDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
