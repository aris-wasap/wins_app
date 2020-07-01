import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_release_list_response.dart'; 
import 'package:meta/meta.dart';

class TransferReleaseListState extends BlocState {
  TransferReleaseListState({
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

  factory TransferReleaseListState.noAction() {
    return TransferReleaseListState(data: List<Data>());
  }

  factory TransferReleaseListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return TransferReleaseListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory TransferReleaseListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return TransferReleaseListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory TransferReleaseListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return TransferReleaseListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
