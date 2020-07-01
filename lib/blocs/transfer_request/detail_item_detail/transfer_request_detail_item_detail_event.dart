import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_request_detail_response.dart';
import 'package:meta/meta.dart';

class TransferRequestDetailItemDetailEvent extends BlocEvent {
  TransferRequestDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class TransferRequestDetailItemDetailEventQty
    extends TransferRequestDetailItemDetailEvent {
  TransferRequestDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 