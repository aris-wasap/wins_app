import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_request_list_response.dart'; 
import 'package:meta/meta.dart';

class TransferRequestListState extends BlocState {
  TransferRequestListState({
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

  factory TransferRequestListState.noAction() {
    return TransferRequestListState(data: List<Data>());
  }

  factory TransferRequestListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return TransferRequestListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory TransferRequestListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return TransferRequestListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory TransferRequestListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return TransferRequestListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
