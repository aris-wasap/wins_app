import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailItemAdditionalDetailEvent extends BlocEvent {
  GoodsIssueDetailItemAdditionalDetailEvent({
    this.data,
    this.itemBatch,
    this.id,
    this.detId,
    this.detDetId,
    this.woId,
    this.woLineNo,
    this.itemCode,
    this.qty,
    this.plannedQty,
    this.whsCode,
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
  final String itemCode;
  final double qty;
  final double plannedQty;
  final String whsCode;
  final int binAbs;
  final String binCode;
  final String qrResult;
  final int itemIndex;
}

class GoodsIssueDetailItemAdditionalDetailEventQty
    extends GoodsIssueDetailItemAdditionalDetailEvent {
  GoodsIssueDetailItemAdditionalDetailEventQty({
    @required double qty,
    @required int binAbs,
    @required String binCode,
  }) : super(qty: qty, binAbs: binAbs, binCode: binCode);
}

class GoodsIssueDetailItemAdditionalDetailEventScan
    extends GoodsIssueDetailItemAdditionalDetailEvent {
  GoodsIssueDetailItemAdditionalDetailEventScan(
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

class GoodsIssueDetailItemAdditionalDetailEventRemoveContent
    extends GoodsIssueDetailItemAdditionalDetailEvent {
  GoodsIssueDetailItemAdditionalDetailEventRemoveContent(
      {@required int id, @required int detId, @required int detDetId})
      : super(id: id, detId: detId, detDetId: detDetId);
}

class GoodsIssueDetailItemAdditionalDetailEventRefreshDetail
    extends GoodsIssueDetailItemAdditionalDetailEvent {
  GoodsIssueDetailItemAdditionalDetailEventRefreshDetail({
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

class GoodsIssueDetailItemAdditionalDetailEventPlannedQtyDetail
    extends GoodsIssueDetailItemAdditionalDetailEvent {
  GoodsIssueDetailItemAdditionalDetailEventPlannedQtyDetail({
    @required int woId,
    @required int id,
    @required int detId,
    @required String itemCode,
    @required double plannedQty,
    @required String whsCode,
    @required int binAbs,
    @required String binCode,
  }) : super(
          woId: woId,
          id: id,
          detId: detId,
          itemCode: itemCode,
          plannedQty: plannedQty,
          whsCode: whsCode,
          binAbs: binAbs,
          binCode: binCode,
        );
}

class GoodsIssueDetailItemAdditionalDetailEventItemAdd
    extends GoodsIssueDetailItemAdditionalDetailEvent {
  GoodsIssueDetailItemAdditionalDetailEventItemAdd({
    @required ItemBatch itemBatch,
  }) : super(
          itemBatch: itemBatch,
        );
}

class GoodsIssueDetailItemAdditionalDetailEventItemUpdate
    extends GoodsIssueDetailItemAdditionalDetailEvent {
  GoodsIssueDetailItemAdditionalDetailEventItemUpdate({
    @required ItemBatch itemBatch,
    @required int itemIndex,
  }) : super(
          itemBatch: itemBatch,
          itemIndex: itemIndex,
        );
}

class GoodsIssueDetailItemAdditionalDetailEventItemRemove
    extends GoodsIssueDetailItemAdditionalDetailEvent {
  GoodsIssueDetailItemAdditionalDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

// class GoodsIssueDetailItemAdditionalDetailEventItemRefresh
//     extends GoodsIssueDetailItemAdditionalDetailEvent {
//   GoodsIssueDetailItemAdditionalDetailEventItemRefresh({
//     @required Item data,
//     @required int itemIndex,
//   }) : super(
//           data: data,
//           itemIndex: itemIndex,
//         );
// }
