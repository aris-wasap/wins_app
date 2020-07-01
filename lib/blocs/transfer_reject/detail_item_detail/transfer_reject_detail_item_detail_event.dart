import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_reject_detail_response.dart';
import 'package:meta/meta.dart';

class TransferRejectDetailItemDetailEvent extends BlocEvent {
  TransferRejectDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class TransferRejectDetailItemDetailEventQty
    extends TransferRejectDetailItemDetailEvent {
  TransferRejectDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 