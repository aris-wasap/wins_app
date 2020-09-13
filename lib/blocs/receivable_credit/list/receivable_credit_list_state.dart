import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receivable_credit_list_response.dart'; 
import 'package:meta/meta.dart';

class ReceivableCreditListState extends BlocState {
  ReceivableCreditListState({
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

  factory ReceivableCreditListState.noAction() {
    return ReceivableCreditListState(data: List<Data>());
  }

  factory ReceivableCreditListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceivableCreditListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceivableCreditListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceivableCreditListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceivableCreditListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return ReceivableCreditListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
