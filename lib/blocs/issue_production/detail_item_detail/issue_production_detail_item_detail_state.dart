import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/issue_production_detail_response.dart';
import 'package:meta/meta.dart';

class IssueProductionDetailItemDetailState extends BlocState {
  IssueProductionDetailItemDetailState({
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

  factory IssueProductionDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return IssueProductionDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory IssueProductionDetailItemDetailState.busy({
    @required Item data,
  }) {
    return IssueProductionDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory IssueProductionDetailItemDetailState.success({
    @required Item data,
  }) {
    return IssueProductionDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory IssueProductionDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return IssueProductionDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
