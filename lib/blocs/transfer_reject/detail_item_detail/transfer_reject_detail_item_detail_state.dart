import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_reject_detail_response.dart';
import 'package:meta/meta.dart';

class TransferRejectDetailItemDetailState extends BlocState {
  TransferRejectDetailItemDetailState({
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

  factory TransferRejectDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return TransferRejectDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory TransferRejectDetailItemDetailState.busy({
    @required Item data,
  }) {
    return TransferRejectDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferRejectDetailItemDetailState.success({
    @required Item data,
  }) {
    return TransferRejectDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory TransferRejectDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return TransferRejectDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
