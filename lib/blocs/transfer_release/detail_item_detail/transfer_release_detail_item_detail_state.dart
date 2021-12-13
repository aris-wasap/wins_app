import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_release_detail_response.dart';
import 'package:meta/meta.dart';

class TransferReleaseDetailItemDetailState extends BlocState {
  TransferReleaseDetailItemDetailState({
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

  factory TransferReleaseDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return TransferReleaseDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory TransferReleaseDetailItemDetailState.busy({
    @required Item data,
  }) {
    return TransferReleaseDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferReleaseDetailItemDetailState.success({
    @required Item data,
  }) {
    return TransferReleaseDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory TransferReleaseDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return TransferReleaseDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
