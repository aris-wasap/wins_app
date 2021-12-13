import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_production_list_response.dart';
import 'package:meta/meta.dart';

class TransferProductionListState extends BlocState {
  TransferProductionListState({
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

  factory TransferProductionListState.noAction() {
    return TransferProductionListState(data: List<Data>());
  }

  factory TransferProductionListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return TransferProductionListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory TransferProductionListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return TransferProductionListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory TransferProductionListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return TransferProductionListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
