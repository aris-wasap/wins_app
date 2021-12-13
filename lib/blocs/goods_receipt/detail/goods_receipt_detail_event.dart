import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsReceiptDetailEvent extends BlocEvent {
  GoodsReceiptDetailEvent({
    this.id,
    this.data,
    this.item,
    this.woId,
    this.woNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final int woId;
  final String woNo;
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
    @required int woId,
    @required String qrResult,
  }) : super(
          data: data,
          woId: woId,
          qrResult: qrResult,
        );
}

class GoodsReceiptDetailEventRefresh extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventRefresh({
    @required int woId,
  }) : super(
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

class GoodsReceiptDetailEventCancel extends GoodsReceiptDetailEvent {
  GoodsReceiptDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
