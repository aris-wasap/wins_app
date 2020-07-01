import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/purchase_returns_detail_response.dart';
import 'package:meta/meta.dart';

class PurchaseReturnsDetailItemDetailState extends BlocState {
  PurchaseReturnsDetailItemDetailState({
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

  factory PurchaseReturnsDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return PurchaseReturnsDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory PurchaseReturnsDetailItemDetailState.busy({
    @required Item data,
  }) {
    return PurchaseReturnsDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory PurchaseReturnsDetailItemDetailState.success({
    @required Item data,
  }) {
    return PurchaseReturnsDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory PurchaseReturnsDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return PurchaseReturnsDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
