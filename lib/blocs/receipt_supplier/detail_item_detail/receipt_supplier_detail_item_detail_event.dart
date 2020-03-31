import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/receipt_supplier_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptSupplierDetailItemDetailEvent extends BlocEvent {
  ReceiptSupplierDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class ReceiptSupplierDetailItemDetailEventQty
    extends ReceiptSupplierDetailItemDetailEvent {
  ReceiptSupplierDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 