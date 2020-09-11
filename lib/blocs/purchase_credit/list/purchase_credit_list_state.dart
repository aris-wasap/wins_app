import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/purchase_credit_list_response.dart'; 
import 'package:meta/meta.dart';

class PurchaseCreditListState extends BlocState {
  PurchaseCreditListState({
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

  factory PurchaseCreditListState.noAction() {
    return PurchaseCreditListState(data: List<Data>());
  }

  factory PurchaseCreditListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return PurchaseCreditListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory PurchaseCreditListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return PurchaseCreditListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory PurchaseCreditListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return PurchaseCreditListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
