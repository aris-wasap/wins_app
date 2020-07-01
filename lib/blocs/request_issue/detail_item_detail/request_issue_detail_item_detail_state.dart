import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/request_issue_detail_response.dart';
import 'package:meta/meta.dart';

class RequestIssueDetailItemDetailState extends BlocState {
  RequestIssueDetailItemDetailState({
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

  factory RequestIssueDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return RequestIssueDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory RequestIssueDetailItemDetailState.busy({
    @required Item data,
  }) {
    return RequestIssueDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory RequestIssueDetailItemDetailState.success({
    @required Item data,
  }) {
    return RequestIssueDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory RequestIssueDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return RequestIssueDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
