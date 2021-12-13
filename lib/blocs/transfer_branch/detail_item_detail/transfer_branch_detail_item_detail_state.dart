import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_branch_detail_response.dart';
import 'package:meta/meta.dart';

class TransferBranchDetailItemDetailState extends BlocState {
  TransferBranchDetailItemDetailState({
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

  factory TransferBranchDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return TransferBranchDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory TransferBranchDetailItemDetailState.busy({
    @required Item data,
  }) {
    return TransferBranchDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferBranchDetailItemDetailState.success({
    @required Item data,
  }) {
    return TransferBranchDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory TransferBranchDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return TransferBranchDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
