import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_issue_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptIssueDetailItemDetailState extends BlocState {
  ReceiptIssueDetailItemDetailState({
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

  factory ReceiptIssueDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return ReceiptIssueDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory ReceiptIssueDetailItemDetailState.busy({
    @required Item data,
  }) {
    return ReceiptIssueDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceiptIssueDetailItemDetailState.success({
    @required Item data,
  }) {
    return ReceiptIssueDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory ReceiptIssueDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return ReceiptIssueDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
