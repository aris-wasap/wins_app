import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_issue_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptIssueDetailEvent extends BlocEvent {
  ReceiptIssueDetailEvent({
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

class ReceiptIssueDetailEventNormal extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventNormal() : super();
}

class ReceiptIssueDetailEventGetId extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class ReceiptIssueDetailEventScan extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventScan({
    @required Data data,
    @required int issueId,
    @required String issueNo,
    @required String qrResult,
  }) : super(
          data: data,
          issueId: issueId,
          issueNo: issueNo,
          qrResult: qrResult,
        );
}

class ReceiptIssueDetailEventItemAdd extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class ReceiptIssueDetailEventItemUpdate extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class ReceiptIssueDetailEventItemRemove extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class ReceiptIssueDetailEventAdd extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceiptIssueDetailEventPost extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceiptIssueDetailEventCancel extends ReceiptIssueDetailEvent {
  ReceiptIssueDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
