import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_request_detail_response.dart';
import 'package:meta/meta.dart';

class TransferRequestDetailState extends BlocState {
  TransferRequestDetailState({
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

  factory TransferRequestDetailState.noAction() {
    return TransferRequestDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory TransferRequestDetailState.busy({
    @required Data data,
  }) {
    return TransferRequestDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferRequestDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return TransferRequestDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory TransferRequestDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return TransferRequestDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
