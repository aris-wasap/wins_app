import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/issue_production_detail_response.dart';
import 'package:meta/meta.dart';

class IssueProductionDetailState extends BlocState {
  IssueProductionDetailState({
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

  factory IssueProductionDetailState.noAction() {
    return IssueProductionDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory IssueProductionDetailState.busy({
    @required Data data,
  }) {
    return IssueProductionDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory IssueProductionDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return IssueProductionDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory IssueProductionDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return IssueProductionDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
