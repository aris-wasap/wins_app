import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsReceiptDetailItemDetailEvent extends BlocEvent {
  GoodsReceiptDetailItemDetailEvent({
    this.data,
    this.itemBatch,
    this.id,
    this.detId,
    this.detDetId,
    this.webId,
    this.woId,
    this.woLineNo,
    this.qty,
    this.binAbs,
    this.binCode,
    this.qrResult,
    this.itemIndex,
  });

  final Item data;
  final ItemBatch itemBatch;
  final int id;
  final int detId;
  final int detDetId;
  final int webId;
  final int woId;
  final int woLineNo;
  final double qty;
  final int binAbs;
  final String binCode;
  final String qrResult;
  final int itemIndex;
}

class GoodsReceiptDetailItemDetailEventQty
    extends GoodsReceiptDetailItemDetailEvent {
  GoodsReceiptDetailItemDetailEventQty({
    @required double qty,
    @required int binAbs,
    @required String binCode,
  }) : super(qty: qty, binAbs: binAbs, binCode: binCode);
}

class GoodsReceiptDetailItemDetailEventScan
    extends GoodsReceiptDetailItemDetailEvent {
  GoodsReceiptDetailItemDetailEventScan(
      {@required Item data,
      @required int id,
      @required int detId,
      @required int webId,
      @required int woId,
      @required int woLineNo,
      @required String qrResult})
      : super(
          data: data,
          id: id,
          detId: detId,
          webId: webId,
          woId: woId,
          woLineNo: woLineNo,
          qrResult: qrResult,
        );
}

class GoodsReceiptDetailItemDetailEventRemoveContent
    extends GoodsReceiptDetailItemDetailEvent {
  GoodsReceiptDetailItemDetailEventRemoveContent({
    @required int id,
    @required int detId,
    @required int detDetId,
  }) : super(
          id: id,
          detId: detId,
          detDetId: detDetId,
        );
}
