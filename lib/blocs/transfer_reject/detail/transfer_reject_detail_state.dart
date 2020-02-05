import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/transfer_reject_detail_response.dart';
import 'package:meta/meta.dart';

class TransferRejectDetailState extends BlocState {
  TransferRejectDetailState({
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

  factory TransferRejectDetailState.noAction() {
    return TransferRejectDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory TransferRejectDetailState.busy({
    @required Data data,
  }) {
    return TransferRejectDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferRejectDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return TransferRejectDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory TransferRejectDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return TransferRejectDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
