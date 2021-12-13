import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_reject_list_response.dart';
import 'package:meta/meta.dart';

class TransferRejectListState extends BlocState {
  TransferRejectListState({
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

  factory TransferRejectListState.noAction() {
    return TransferRejectListState(data: List<Data>());
  }

  factory TransferRejectListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return TransferRejectListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory TransferRejectListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return TransferRejectListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory TransferRejectListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return TransferRejectListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
