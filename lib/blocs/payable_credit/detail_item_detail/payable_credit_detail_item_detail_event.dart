import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/payable_credit_detail_response.dart';
import 'package:meta/meta.dart';

class PayableCreditDetailItemDetailEvent extends BlocEvent {
  PayableCreditDetailItemDetailEvent({
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

class PayableCreditDetailItemDetailEventQty
    extends PayableCreditDetailItemDetailEvent {
  PayableCreditDetailItemDetailEventQty({
    @required double qty,@required int binAbs,  @required String binCode,
  }) : super(
          qty: qty,
          binAbs: binAbs,
          binCode:binCode
        );
}
 