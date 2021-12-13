import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/request_issue_list_response.dart';
import 'package:meta/meta.dart';

class RequestIssueListState extends BlocState {
  RequestIssueListState({
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

  factory RequestIssueListState.noAction() {
    return RequestIssueListState(data: List<Data>());
  }

  factory RequestIssueListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return RequestIssueListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory RequestIssueListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return RequestIssueListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory RequestIssueListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return RequestIssueListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
