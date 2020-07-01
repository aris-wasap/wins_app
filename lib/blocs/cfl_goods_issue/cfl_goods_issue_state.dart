import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_goods_issue_response.dart'; 
import 'package:meta/meta.dart';

class CflGoodsIssueState extends BlocState {
  CflGoodsIssueState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false, 
    this.isActiveSearch: false,
    this.errorMessage: '',
    @required this.selectedRows,
  });

  final List<Data> data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure; 
  final bool isActiveSearch;
  final String errorMessage;
  final List<Data> selectedRows;

  factory CflGoodsIssueState.noAction() {
    return CflGoodsIssueState(
      data: List<Data>(),
      selectedRows: List<Data>(),
    );
  }

  factory CflGoodsIssueState.busy({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflGoodsIssueState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflGoodsIssueState.success({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflGoodsIssueState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflGoodsIssueState.failure({
    @required List<Data> data,
    @required String errorMessage,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflGoodsIssueState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }
}
