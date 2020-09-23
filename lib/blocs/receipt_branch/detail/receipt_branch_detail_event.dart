import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptBranchDetailEvent extends BlocEvent {
  ReceiptBranchDetailEvent({
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

class ReceiptBranchDetailEventNormal extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventNormal() : super();
}

class ReceiptBranchDetailEventGetId extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class ReceiptBranchDetailEventScan extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventScan({
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

class ReceiptBranchDetailEventItemAdd extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class ReceiptBranchDetailEventItemUpdate extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class ReceiptBranchDetailEventItemRemove extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class ReceiptBranchDetailEventAdd extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceiptBranchDetailEventPost extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceiptBranchDetailEventCancel extends ReceiptBranchDetailEvent {
  ReceiptBranchDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
