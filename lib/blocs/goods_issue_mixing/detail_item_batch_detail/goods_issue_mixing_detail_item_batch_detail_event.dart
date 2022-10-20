import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueMixingDetailItemBatchDetailEvent extends BlocEvent {
  GoodsIssueMixingDetailItemBatchDetailEvent(
      {this.data,
      this.id,
      this.detId,
      this.woId,
      this.woLineNo,
      this.qty,
      this.binAbs,
      this.binCode,
      this.qrResult});

  final ItemBatch data;
  final int id;
  final int detId;
  final int woId;
  final int woLineNo;
  final double qty;
  final int binAbs;
  final String binCode;
  final String qrResult;
}

class GoodsIssueMixingDetailItemBatchDetailEventQty
    extends GoodsIssueMixingDetailItemBatchDetailEvent {
  GoodsIssueMixingDetailItemBatchDetailEventQty({
    @required double qty,
    @required int binAbs,
    @required String binCode,
  }) : super(qty: qty, binAbs: binAbs, binCode: binCode);
}

class GoodsIssueMixingDetailItemBatchDetailEventScanBatch
    extends GoodsIssueMixingDetailItemBatchDetailEvent {
  GoodsIssueMixingDetailItemBatchDetailEventScanBatch(
      {@required ItemBatch data,
      @required int id,
      @required int detId,
      @required int woId,
      @required int woLineNo,
      @required String qrResult})
      : super(
          data: data,
          id: id,
          detId: detId,
          woId: woId,
          woLineNo: woLineNo,
          qrResult: qrResult,
        );
}
