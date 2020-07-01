import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/request_issue_detail_response.dart';
import 'package:meta/meta.dart';

class RequestIssueDetailState extends BlocState {
  RequestIssueDetailState({
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

  factory RequestIssueDetailState.noAction() {
    return RequestIssueDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory RequestIssueDetailState.busy({
    @required Data data,
  }) {
    return RequestIssueDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory RequestIssueDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return RequestIssueDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory RequestIssueDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return RequestIssueDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
