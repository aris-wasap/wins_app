import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/payable_credit_list_response.dart'; 
import 'package:meta/meta.dart';

class PayableCreditListState extends BlocState {
  PayableCreditListState({
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

  factory PayableCreditListState.noAction() {
    return PayableCreditListState(data: List<Data>());
  }

  factory PayableCreditListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return PayableCreditListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory PayableCreditListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return PayableCreditListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory PayableCreditListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return PayableCreditListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
