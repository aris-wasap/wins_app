import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/delivery_order_list_response.dart'; 
import 'package:meta/meta.dart';

class DeliveryOrderListState extends BlocState {
  DeliveryOrderListState({
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

  factory DeliveryOrderListState.noAction() {
    return DeliveryOrderListState(data: List<Data>());
  }

  factory DeliveryOrderListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return DeliveryOrderListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory DeliveryOrderListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return DeliveryOrderListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory DeliveryOrderListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return DeliveryOrderListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
