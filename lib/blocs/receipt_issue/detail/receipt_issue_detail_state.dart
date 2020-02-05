import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/receipt_issue_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptIssueDetailState extends BlocState {
  ReceiptIssueDetailState({
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

  factory ReceiptIssueDetailState.noAction() {
    return ReceiptIssueDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory ReceiptIssueDetailState.busy({
    @required Data data,
  }) {
    return ReceiptIssueDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory ReceiptIssueDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return ReceiptIssueDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory ReceiptIssueDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return ReceiptIssueDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
