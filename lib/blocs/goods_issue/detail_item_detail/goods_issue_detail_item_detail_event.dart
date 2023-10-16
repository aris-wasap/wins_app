import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailItemDetailEvent extends BlocEvent {
  GoodsIssueDetailItemDetailEvent({
    this.data,
    this.itemBatch,
    this.id,
    this.detId,
    this.detDetId,
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
  final int woId;
  final int woLineNo;
  final double qty;
  final int binAbs;
  final String binCode;
  final String qrResult;
  final int itemIndex;
}

class GoodsIssueDetailItemDetailEventQty
    extends GoodsIssueDetailItemDetailEvent {
  GoodsIssueDetailItemDetailEventQty({
    @required double qty,
    @required int binAbs,
    @required String binCode,
  }) : super(qty: qty, binAbs: binAbs, binCode: binCode);
}

class GoodsIssueDetailItemDetailEventScan
    extends GoodsIssueDetailItemDetailEvent {
  GoodsIssueDetailItemDetailEventScan(
      {@required Item data,
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

class GoodsIssueDetailItemDetailEventRemoveContent
    extends GoodsIssueDetailItemDetailEvent {
  GoodsIssueDetailItemDetailEventRemoveContent(
      {@required int id, @required int detId, @required int detDetId})
      : super(id: id, detId: detId, detDetId: detDetId);
}

class GoodsIssueDetailItemDetailEventRefreshDetail
    extends GoodsIssueDetailItemDetailEvent {
  GoodsIssueDetailItemDetailEventRefreshDetail({
    @required int id,
    @required int detId,
    @required double qtyItem,
    @required Item newDataItem,
  }) : super(
          id: id,
          detId: detId,
          qty: qtyItem,
          data: newDataItem,
        );
}

class GoodsIssueDetailItemDetailEventItemAdd
    extends GoodsIssueDetailItemDetailEvent {
  GoodsIssueDetailItemDetailEventItemAdd({
    @required ItemBatch itemBatch,
  }) : super(
          itemBatch: itemBatch,
        );
}

class GoodsIssueDetailItemDetailEventItemUpdate
    extends GoodsIssueDetailItemDetailEvent {
  GoodsIssueDetailItemDetailEventItemUpdate({
    @required ItemBatch itemBatch,
    @required int itemIndex,
  }) : super(
          itemBatch: itemBatch,
          itemIndex: itemIndex,
        );
}

class GoodsIssueDetailItemDetailEventItemRemove
    extends GoodsIssueDetailItemDetailEvent {
  GoodsIssueDetailItemDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

// class GoodsIssueDetailItemDetailEventItemRefresh
//     extends GoodsIssueDetailItemDetailEvent {
//   GoodsIssueDetailItemDetailEventItemRefresh({
//     @required Item data,
//     @required int itemIndex,
//   }) : super(
//           data: data,
//           itemIndex: itemIndex,
//         );
// }
