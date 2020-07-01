import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/inventory_transfer_detail_response.dart';
import 'package:meta/meta.dart';

class InventoryTransferDetailItemDetailEvent extends BlocEvent {
  InventoryTransferDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class InventoryTransferDetailItemDetailEventQty
    extends InventoryTransferDetailItemDetailEvent {
  InventoryTransferDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 