import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/transfer_release_detail_response.dart';
import 'package:meta/meta.dart';

class TransferReleaseDetailState extends BlocState {
  TransferReleaseDetailState({
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

  factory TransferReleaseDetailState.noAction() {
    return TransferReleaseDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory TransferReleaseDetailState.busy({
    @required Data data,
  }) {
    return TransferReleaseDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferReleaseDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return TransferReleaseDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory TransferReleaseDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return TransferReleaseDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
