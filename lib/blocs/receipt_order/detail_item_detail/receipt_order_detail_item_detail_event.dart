import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/receipt_order_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptOrderDetailItemDetailEvent extends BlocEvent {
  ReceiptOrderDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class ReceiptOrderDetailItemDetailEventQty
    extends ReceiptOrderDetailItemDetailEvent {
  ReceiptOrderDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 