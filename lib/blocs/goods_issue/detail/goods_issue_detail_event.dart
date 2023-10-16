import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';

class GoodsIssueDetailEvent extends BlocEvent {
  GoodsIssueDetailEvent({
    this.id,
    this.detId,
    this.data,
    this.item,
    this.woId,
    this.transDate,
    this.woNo,
    this.itemIndex,
    this.qrResult,
    this.weightProd,
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
  final double weightProd;
}

class GoodsIssueDetailEventNormal extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventNormal() : super();
}

class GoodsIssueDetailEventGetId extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class GoodsIssueDetailEventScan extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventScan({
    @required Data data,
    @required int woId,
    @required String qrResult,
  }) : super(
          data: data,
          woId: woId,
          qrResult: qrResult,
        );
}

class GoodsIssueDetailEventRefresh extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventRefresh({
    @required int woId,
    @required String transDate,
  }) : super(
          woId: woId,
          transDate: transDate,
        );
}

class GoodsIssueDetailEventGetWeightProduction extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventGetWeightProduction({
    @required int id,
    @required int woId,
    @required double weightProd,
  }) : super(
          id: id,
          woId: woId,
          weightProd: weightProd,
        );
}

class GoodsIssueDetailEventResetData extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventResetData({
    @required int id,
    @required int woId,
  }) : super(
          id: id,
          woId: woId,
        );
}

class GoodsIssueDetailEventRefreshAfter extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventRefreshAfter({
    @required int id,
    @required Data newData,
  }) : super(
          id: id,
          data: newData,
        );
}

class GoodsIssueDetailEventItemAdd extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class GoodsIssueDetailEventItemUpdate extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class GoodsIssueDetailEventItemRemove extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class GoodsIssueDetailEventAdd extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class GoodsIssueDetailEventPost extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class GoodsIssueDetailEventUpdateTransDate extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventUpdateTransDate({
    @required int id,
    @required String transDate,
  }) : super(
          id: id,
          transDate: transDate,
        );
}

class GoodsIssueDetailEventCancel extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventCancel({
    @required int id,
    @required Data data,
  }) : super(
          id: id,
          data: data,
        );
}

class GoodsIssueDetailEventRemoveItem extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventRemoveItem({
    @required int id,
    @required int detId,
  }) : super(id: id, detId: detId);
}
