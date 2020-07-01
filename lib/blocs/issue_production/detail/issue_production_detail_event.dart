import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/issue_production_detail_response.dart';
import 'package:meta/meta.dart';

class IssueProductionDetailEvent extends BlocEvent {
  IssueProductionDetailEvent({
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

class IssueProductionDetailEventNormal extends IssueProductionDetailEvent {
  IssueProductionDetailEventNormal() : super();
}

class IssueProductionDetailEventGetId extends IssueProductionDetailEvent {
  IssueProductionDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class IssueProductionDetailEventScan extends IssueProductionDetailEvent {
  IssueProductionDetailEventScan({
    @required Data data,
    @required int woId,
    @required String woNo,
    @required String qrResult,
  }) : super(
          data: data,
          woId: woId,
          woNo: woNo,
          qrResult: qrResult,
        );
}

class IssueProductionDetailEventItemAdd extends IssueProductionDetailEvent {
  IssueProductionDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class IssueProductionDetailEventItemUpdate extends IssueProductionDetailEvent {
  IssueProductionDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class IssueProductionDetailEventItemRemove extends IssueProductionDetailEvent {
  IssueProductionDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class IssueProductionDetailEventAdd extends IssueProductionDetailEvent {
  IssueProductionDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class IssueProductionDetailEventCancel extends IssueProductionDetailEvent {
  IssueProductionDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
