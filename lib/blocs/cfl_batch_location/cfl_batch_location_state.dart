import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_batch_location_response.dart';
import 'package:meta/meta.dart';

class CflBatchLocationState extends BlocState {
  CflBatchLocationState({
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

  factory CflBatchLocationState.noAction() {
    return CflBatchLocationState(
      data: List<Data>(),
      selectedRows: List<Data>(),
    );
  }

  factory CflBatchLocationState.busy({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflBatchLocationState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflBatchLocationState.success({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflBatchLocationState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflBatchLocationState.failure({
    @required List<Data> data,
    @required String errorMessage,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflBatchLocationState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }
}
