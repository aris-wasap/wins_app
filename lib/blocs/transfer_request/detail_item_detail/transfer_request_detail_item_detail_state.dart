import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_request_detail_response.dart';
import 'package:meta/meta.dart';

class TransferRequestDetailItemDetailState extends BlocState {
  TransferRequestDetailItemDetailState({
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

  factory TransferRequestDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return TransferRequestDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory TransferRequestDetailItemDetailState.busy({
    @required Item data,
  }) {
    return TransferRequestDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferRequestDetailItemDetailState.success({
    @required Item data,
  }) {
    return TransferRequestDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory TransferRequestDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return TransferRequestDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
