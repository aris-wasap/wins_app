import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_transfer_request_response.dart'; 
import 'package:meta/meta.dart';

class CflTransferRequestState extends BlocState {
  CflTransferRequestState({
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

  factory CflTransferRequestState.noAction() {
    return CflTransferRequestState(
      data: List<Data>(),
      selectedRows: List<Data>(),
    );
  }

  factory CflTransferRequestState.busy({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflTransferRequestState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflTransferRequestState.success({
    @required List<Data> data,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflTransferRequestState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }

  factory CflTransferRequestState.failure({
    @required List<Data> data,
    @required String errorMessage,
    @required bool isActiveSearch,
    @required List<Data> selectedRows,
  }) {
    return CflTransferRequestState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
      selectedRows: selectedRows,
    );
  }
}
