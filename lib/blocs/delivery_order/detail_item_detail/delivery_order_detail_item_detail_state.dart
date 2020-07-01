import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/delivery_order_detail_response.dart';
import 'package:meta/meta.dart';

class DeliveryOrderDetailItemDetailState extends BlocState {
  DeliveryOrderDetailItemDetailState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.errorMessage: '',
  });

  final Item data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  factory DeliveryOrderDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return DeliveryOrderDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory DeliveryOrderDetailItemDetailState.busy({
    @required Item data,
  }) {
    return DeliveryOrderDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory DeliveryOrderDetailItemDetailState.success({
    @required Item data,
  }) {
    return DeliveryOrderDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory DeliveryOrderDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return DeliveryOrderDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
