import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/delivery_order_detail_response.dart';
import 'package:meta/meta.dart';

class DeliveryOrderDetailState extends BlocState {
  DeliveryOrderDetailState({
    @required this.data,
    this.newItem,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.succesMessage: '',
    this.errorMessage: '',
  });

  final Data data;
  final Item newItem;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String succesMessage;
  final String errorMessage;

  factory DeliveryOrderDetailState.noAction() {
    return DeliveryOrderDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory DeliveryOrderDetailState.busy({
    @required Data data,
  }) {
    return DeliveryOrderDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory DeliveryOrderDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return DeliveryOrderDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory DeliveryOrderDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return DeliveryOrderDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
