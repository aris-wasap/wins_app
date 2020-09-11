import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/purchase_credit_detail_response.dart';
import 'package:meta/meta.dart';

class PurchaseCreditDetailItemDetailState extends BlocState {
  PurchaseCreditDetailItemDetailState({
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

  factory PurchaseCreditDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return PurchaseCreditDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory PurchaseCreditDetailItemDetailState.busy({
    @required Item data,
  }) {
    return PurchaseCreditDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory PurchaseCreditDetailItemDetailState.success({
    @required Item data,
  }) {
    return PurchaseCreditDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory PurchaseCreditDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return PurchaseCreditDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
