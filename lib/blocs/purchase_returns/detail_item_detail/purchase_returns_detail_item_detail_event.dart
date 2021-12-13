import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/purchase_returns_detail_response.dart';
import 'package:meta/meta.dart';

class PurchaseReturnsDetailItemDetailEvent extends BlocEvent {
  PurchaseReturnsDetailItemDetailEvent(
      {this.data, this.qty, this.binAbs, this.binCode});

  final Item data;
  final double qty;
  final int binAbs;
  final String binCode;
}

class PurchaseReturnsDetailItemDetailEventQty
    extends PurchaseReturnsDetailItemDetailEvent {
  PurchaseReturnsDetailItemDetailEventQty({
    @required double qty,
    @required int binAbs,
    @required String binCode,
  }) : super(qty: qty, binAbs: binAbs, binCode: binCode);
}
