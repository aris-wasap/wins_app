import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_production_detail_response.dart';
import 'package:meta/meta.dart';

class TransferProductionDetailItemDetailEvent extends BlocEvent {
  TransferProductionDetailItemDetailEvent({
    this.data,
    this.qty,
  });

  final Item data;
  final double qty;
}

class TransferProductionDetailItemDetailEventQty
    extends TransferProductionDetailItemDetailEvent {
  TransferProductionDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
