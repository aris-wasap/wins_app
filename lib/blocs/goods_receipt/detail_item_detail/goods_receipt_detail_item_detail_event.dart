import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/goods_receipt_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsReceiptDetailItemDetailEvent extends BlocEvent {
  GoodsReceiptDetailItemDetailEvent({
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

class GoodsReceiptDetailItemDetailEventQty
    extends GoodsReceiptDetailItemDetailEvent {
  GoodsReceiptDetailItemDetailEventQty({
    @required double qty,@required int binAbs,  @required String binCode,
  }) : super(
          qty: qty,
          binAbs: binAbs,
          binCode:binCode
        );
}
 