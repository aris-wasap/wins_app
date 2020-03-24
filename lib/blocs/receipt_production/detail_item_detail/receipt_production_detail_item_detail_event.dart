import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/receipt_production_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptProductionDetailItemDetailEvent extends BlocEvent {
  ReceiptProductionDetailItemDetailEvent({
    this.data,
    this.qty, 
    this.binAbs,

  });

  final Item data;
  final double qty; 
  final int binAbs;
}

class ReceiptProductionDetailItemDetailEventQty
    extends ReceiptProductionDetailItemDetailEvent {
  ReceiptProductionDetailItemDetailEventQty({
    @required double qty,  @required int binAbs,
  }) : super(
          qty: qty,
          binAbs : binAbs,
        );
}
 