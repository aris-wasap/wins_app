import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receivable_credit_detail_response.dart';
import 'package:meta/meta.dart';

class ReceivableCreditDetailItemDetailState extends BlocState {
  ReceivableCreditDetailItemDetailState({
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

  factory ReceivableCreditDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return ReceivableCreditDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory ReceivableCreditDetailItemDetailState.busy({
    @required Item data,
  }) {
    return ReceivableCreditDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceivableCreditDetailItemDetailState.success({
    @required Item data,
  }) {
    return ReceivableCreditDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory ReceivableCreditDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return ReceivableCreditDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
