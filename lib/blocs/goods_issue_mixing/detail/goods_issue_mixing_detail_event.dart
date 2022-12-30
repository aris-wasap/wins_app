import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';

class GoodsIssueMixingDetailEvent extends BlocEvent {
  GoodsIssueMixingDetailEvent({
    this.id,
    this.detId,
    this.data,
    this.item,
    this.woId,
    this.transDate,
    this.woNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final int detId;
  final Data data;
  final Item item;
  final int woId;
  final String transDate;
  final String woNo;
  final int itemIndex;
  final String qrResult;
}

class GoodsIssueMixingDetailEventNormal extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventNormal() : super();
}

class GoodsIssueMixingDetailEventGetId extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class GoodsIssueMixingDetailEventScan extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventScan({
    @required Data data,
    @required int woId,
    @required String qrResult,
  }) : super(
          data: data,
          woId: woId,
          qrResult: qrResult,
        );
}

class GoodsIssueMixingDetailEventRefresh extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventRefresh({
    @required int woId,
    @required String transDate,
  }) : super(
          woId: woId,
          transDate: transDate,
        );
}

class GoodsIssueMixingDetailEventResetData extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventResetData({
    @required int id,
    @required int woId,
  }) : super(
          id: id,
          woId: woId,
        );
}

class GoodsIssueMixingDetailEventRefreshAfter
    extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventRefreshAfter({
    @required int id,
    @required Data newData,
  }) : super(
          id: id,
          data: newData,
        );
}

class GoodsIssueMixingDetailEventItemAdd extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class GoodsIssueMixingDetailEventItemUpdate
    extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class GoodsIssueMixingDetailEventItemRemove
    extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class GoodsIssueMixingDetailEventAdd extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class GoodsIssueMixingDetailEventPost extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class GoodsIssueMixingDetailEventUpdateTransDate
    extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventUpdateTransDate({
    @required int id,
    @required String transDate,
  }) : super(
          id: id,
          transDate: transDate,
        );
}

class GoodsIssueMixingDetailEventCancel extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventCancel({
    @required int id,
    @required Data data,
  }) : super(
          id: id,
          data: data,
        );
}

class GoodsIssueMixingDetailEventRemoveItem
    extends GoodsIssueMixingDetailEvent {
  GoodsIssueMixingDetailEventRemoveItem({
    @required int id,
    @required int detId,
  }) : super(id: id, detId: detId);
}
