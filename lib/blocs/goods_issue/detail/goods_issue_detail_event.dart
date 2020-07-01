import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailEvent extends BlocEvent {
  GoodsIssueDetailEvent({
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
  }) : super(
          woId: woId,
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

class GoodsIssueDetailEventCancel extends GoodsIssueDetailEvent {
  GoodsIssueDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
