import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueMixingDetailItemDetailEvent extends BlocEvent {
  GoodsIssueMixingDetailItemDetailEvent(
      {this.data,
      this.woId,
      this.woLineNo,
      this.qty,
      this.binAbs,
      this.binCode,
      this.qrResult});

  final Item data;
  final int woId;
  final int woLineNo;
  final double qty;
  final int binAbs;
  final String binCode;
  final String qrResult;
}

class GoodsIssueMixingDetailItemDetailEventQty
    extends GoodsIssueMixingDetailItemDetailEvent {
  GoodsIssueMixingDetailItemDetailEventQty({
    @required double qty,
    @required int binAbs,
    @required String binCode,
  }) : super(qty: qty, binAbs: binAbs, binCode: binCode);
}

class GoodsIssueMixingDetailItemDetailEventScan
    extends GoodsIssueMixingDetailItemDetailEvent {
  GoodsIssueMixingDetailItemDetailEventScan(
      {@required Item data,
      @required int woId,
      @required int woLineNo,
      @required String qrResult})
      : super(
          data: data,
          woId: woId,
          woLineNo: woLineNo,
          qrResult: qrResult,
        );
}
