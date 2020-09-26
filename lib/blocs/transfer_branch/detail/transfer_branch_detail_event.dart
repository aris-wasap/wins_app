import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_branch_detail_response.dart';
import 'package:meta/meta.dart';

class TransferBranchDetailEvent extends BlocEvent {
  TransferBranchDetailEvent({
    this.id,
    this.data,
    this.item,
    this.issueId,
    this.issueNo,
    this.requestId,
    this.requestNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final int issueId;
  final String issueNo;
  final int requestId;
  final String requestNo;
  final int itemIndex;
  final String qrResult;
}

class TransferBranchDetailEventNormal extends TransferBranchDetailEvent {
  TransferBranchDetailEventNormal() : super();
}

class TransferBranchDetailEventGetId extends TransferBranchDetailEvent {
  TransferBranchDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class TransferBranchDetailEventScan extends TransferBranchDetailEvent {
  TransferBranchDetailEventScan({
    @required Data data,
    @required int requestId,
    @required String requestNo,
    @required String qrResult,
  }) : super(
          data: data,
          requestId: requestId,
          requestNo: requestNo,
          qrResult: qrResult,
        );
}

class TransferBranchDetailEventItemAdd extends TransferBranchDetailEvent {
  TransferBranchDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class TransferBranchDetailEventItemUpdate extends TransferBranchDetailEvent {
  TransferBranchDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class TransferBranchDetailEventItemRemove extends TransferBranchDetailEvent {
  TransferBranchDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class TransferBranchDetailEventAdd extends TransferBranchDetailEvent {
  TransferBranchDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class TransferBranchDetailEventPost extends TransferBranchDetailEvent {
  TransferBranchDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class TransferBranchDetailEventCancel extends TransferBranchDetailEvent {
  TransferBranchDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
