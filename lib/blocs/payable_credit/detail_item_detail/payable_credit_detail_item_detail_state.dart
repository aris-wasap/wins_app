import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/payable_credit_detail_response.dart';
import 'package:meta/meta.dart';

class PayableCreditDetailItemDetailState extends BlocState {
  PayableCreditDetailItemDetailState({
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

  factory PayableCreditDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return PayableCreditDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory PayableCreditDetailItemDetailState.busy({
    @required Item data,
  }) {
    return PayableCreditDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory PayableCreditDetailItemDetailState.success({
    @required Item data,
  }) {
    return PayableCreditDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory PayableCreditDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return PayableCreditDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
