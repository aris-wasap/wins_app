import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_item_batch_response.dart'; 
import 'package:meta/meta.dart';

class CflItemBatchState extends BlocState {
  CflItemBatchState({
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

  factory CflItemBatchState.noAction() {
    return CflItemBatchState(
      data: List<Data>(),
      selectedRows: List<Data>(),
    );
  }

  factory CflItemBatchState.busy({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflItemBatchState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflItemBatchState.success({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflItemBatchState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflItemBatchState.failure({
    @required List<Data> data,
    @required String errorMessage,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflItemBatchState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }
}
