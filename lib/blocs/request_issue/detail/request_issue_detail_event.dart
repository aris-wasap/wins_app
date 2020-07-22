import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/request_issue_detail_response.dart';
import 'package:meta/meta.dart';

class RequestIssueDetailEvent extends BlocEvent {
  RequestIssueDetailEvent({
    this.id,
    this.data,
    this.item,
    this.issueId,
    this.issueNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final int issueId;
  final String issueNo;
  final int itemIndex;
  final String qrResult;
}

class RequestIssueDetailEventNormal extends RequestIssueDetailEvent {
  RequestIssueDetailEventNormal() : super();
}

class RequestIssueDetailEventGetId extends RequestIssueDetailEvent {
  RequestIssueDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class RequestIssueDetailEventScan extends RequestIssueDetailEvent {
  RequestIssueDetailEventScan({
    @required Data data,
    @required String qrResult,
  }) : super(
          data: data,
          qrResult: qrResult,
        );
}

class RequestIssueDetailEventItemAdd extends RequestIssueDetailEvent {
  RequestIssueDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class RequestIssueDetailEventItemUpdate extends RequestIssueDetailEvent {
  RequestIssueDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class RequestIssueDetailEventItemRemove extends RequestIssueDetailEvent {
  RequestIssueDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class RequestIssueDetailEventAdd extends RequestIssueDetailEvent {
  RequestIssueDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class RequestIssueDetailEventCancel extends RequestIssueDetailEvent {
  RequestIssueDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}