import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receivable_credit_detail_response.dart';
import 'package:meta/meta.dart';

class ReceivableCreditDetailItemDetailEvent extends BlocEvent {
  ReceivableCreditDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class ReceivableCreditDetailItemDetailEventQty
    extends ReceivableCreditDetailItemDetailEvent {
  ReceivableCreditDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 