import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_payable_return_request_response.dart';
import 'package:meta/meta.dart';

class CflPayableReturnRequestState extends BlocState {
  CflPayableReturnRequestState({
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

  factory CflPayableReturnRequestState.noAction() {
    return CflPayableReturnRequestState(
      data: List<Data>(),
      selectedRows: List<Data>(),
    );
  }

  factory CflPayableReturnRequestState.busy({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflPayableReturnRequestState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflPayableReturnRequestState.success({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflPayableReturnRequestState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflPayableReturnRequestState.failure({
    @required List<Data> data,
    @required String errorMessage,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflPayableReturnRequestState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }
}
