import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptBranchDetailItemDetailState extends BlocState {
  ReceiptBranchDetailItemDetailState({
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

  factory ReceiptBranchDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return ReceiptBranchDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory ReceiptBranchDetailItemDetailState.busy({
    @required Item data,
  }) {
    return ReceiptBranchDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceiptBranchDetailItemDetailState.success({
    @required Item data,
  }) {
    return ReceiptBranchDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory ReceiptBranchDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return ReceiptBranchDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
