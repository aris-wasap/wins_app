import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/delivery_order/detail_item_detail/delivery_order_detail_item_detail_event.dart';
import 'package:ncf_app/blocs/delivery_order/detail_item_detail/delivery_order_detail_item_detail_state.dart';
import 'package:ncf_app/models/delivery_order_detail_response.dart';

class DeliveryOrderDetailItemDetailBloc extends BlocEventStateBase<
    DeliveryOrderDetailItemDetailEvent, DeliveryOrderDetailItemDetailState> {
  DeliveryOrderDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: DeliveryOrderDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<DeliveryOrderDetailItemDetailState> eventHandler(
      DeliveryOrderDetailItemDetailEvent event,
      DeliveryOrderDetailItemDetailState currentState) async* {
    if (event is DeliveryOrderDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield DeliveryOrderDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
