import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/issue_production_list_response.dart'; 
import 'package:meta/meta.dart';

class IssueProductionListState extends BlocState {
  IssueProductionListState({
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

  factory IssueProductionListState.noAction() {
    return IssueProductionListState(data: List<Data>());
  }

  factory IssueProductionListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return IssueProductionListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory IssueProductionListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return IssueProductionListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory IssueProductionListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return IssueProductionListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
