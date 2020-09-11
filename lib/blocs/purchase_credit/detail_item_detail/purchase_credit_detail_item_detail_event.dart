import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/purchase_credit_detail_response.dart';
import 'package:meta/meta.dart';

class PurchaseCreditDetailItemDetailEvent extends BlocEvent {
  PurchaseCreditDetailItemDetailEvent({
    this.data,
    this.qty,
    this.binAbs,
    this.binCode 
  });

  final Item data;
  final double qty;
  final int binAbs;
  final String binCode; 
}

class PurchaseCreditDetailItemDetailEventQty
    extends PurchaseCreditDetailItemDetailEvent {
  PurchaseCreditDetailItemDetailEventQty({
    @required double qty,@required int binAbs,  @required String binCode,
  }) : super(
          qty: qty,
          binAbs: binAbs,
          binCode:binCode
        );
}
 