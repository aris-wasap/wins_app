import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_item_response.dart';
import 'package:meta/meta.dart';

class CflItemState extends BlocState {
  CflItemState({
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

  factory CflItemState.noAction() {
    return CflItemState(
      data: List<Data>(),
      selectedRows: List<Data>(),
    );
  }

  factory CflItemState.busy({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflItemState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflItemState.success({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflItemState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflItemState.failure({
    @required List<Data> data,
    @required String errorMessage,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflItemState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }
}
