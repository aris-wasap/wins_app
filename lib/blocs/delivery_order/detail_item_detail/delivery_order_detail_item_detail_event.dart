import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/delivery_order_detail_response.dart';
import 'package:meta/meta.dart';

class DeliveryOrderDetailItemDetailEvent extends BlocEvent {
  DeliveryOrderDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class DeliveryOrderDetailItemDetailEventQty
    extends DeliveryOrderDetailItemDetailEvent {
  DeliveryOrderDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 