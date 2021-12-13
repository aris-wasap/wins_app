import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_issue_list_response.dart';
import 'package:meta/meta.dart';

class ReceiptIssueListState extends BlocState {
  ReceiptIssueListState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.isActiveSearch: false,
    this.errorMessage: '',
  });

  final List<Data> data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final bool isActiveSearch;
  final String errorMessage;

  factory ReceiptIssueListState.noAction() {
    return ReceiptIssueListState(data: List<Data>());
  }

  factory ReceiptIssueListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptIssueListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptIssueListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptIssueListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptIssueListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return ReceiptIssueListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
