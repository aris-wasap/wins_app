import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsReceiptDetailEvent extends BlocEvent {
  GoodsReceiptDetailEvent({
    this.id,
    this.detId,
    this.transDate,
    this.data,
    this.item,
    this.woId,
    this.woNo,
    this.webId,
    this.sapGoodsIssueId,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final int detId;
  final String transDate;
  final Data data;
  final Item item;
  final int woId;
  final String woNo;
  final int webId;
  final int sapGoodsIssueId;
  final int itemIndex;
  final String qrResult;
}

class GoodsReceiptDetailEventNormal extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventNormal() : super();
}

class GoodsReceiptDetailEventGetId extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class GoodsReceiptDetailEventScan extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventScan({
    @required Data data,
    @required int webId,
    @required String qrResult,
  }) : super(
          data: data,
          webId: webId,
          qrResult: qrResult,
        );
}

class GoodsReceiptDetailEventRefresh extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventRefresh({
    @required int webId,
    @required int sapGoodsIssueId,
    @required String transDate,
  }) : super(
          webId: webId,
          sapGoodsIssueId: sapGoodsIssueId,
          transDate: transDate,
        );
}

class GoodsReceiptDetailEventResetData extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventResetData({
    @required int id,
    @required int woId,
  }) : super(
          id: id,
          woId: woId,
        );
}

class GoodsReceiptDetailEventItemAdd extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class GoodsReceiptDetailEventItemUpdate extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class GoodsReceiptDetailEventItemRemove extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class GoodsReceiptDetailEventAdd extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class GoodsReceiptDetailEventUpdate extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventUpdate({
    @required Data data,
  }) : super(
          data: data,
        );
}

class GoodsReceiptDetailEventPost extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class GoodsReceiptDetailEventCancel extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventCancel({
    @required int id,
    @required Data data,
  }) : super(
          id: id,
          data: data,
        );
}

class GoodsReceiptDetailEventRemoveItem extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventRemoveItem({
    @required int id,
    @required int detId,
  }) : super(
          id: id,
          detId: detId,
        );
}
