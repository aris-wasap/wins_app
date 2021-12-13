import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_production_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptProductionDetailItemDetailEvent extends BlocEvent {
  ReceiptProductionDetailItemDetailEvent(
      {this.data, this.qty, this.binAbs, this.binCode});

  final Item data;
  final double qty;
  final int binAbs;
  final String binCode;
}

class ReceiptProductionDetailItemDetailEventQty
    extends ReceiptProductionDetailItemDetailEvent {
  ReceiptProductionDetailItemDetailEventQty({
    @required double qty,
    @required int binAbs,
    @required String binCode,
  }) : super(
          qty: qty,
          binAbs: binAbs,
          binCode: binCode,
        );
}
