import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/purchase_returns_list_response.dart';
import 'package:meta/meta.dart';

class PurchaseReturnsListState extends BlocState {
  PurchaseReturnsListState({
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

  factory PurchaseReturnsListState.noAction() {
    return PurchaseReturnsListState(data: List<Data>());
  }

  factory PurchaseReturnsListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return PurchaseReturnsListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory PurchaseReturnsListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return PurchaseReturnsListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory PurchaseReturnsListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return PurchaseReturnsListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
