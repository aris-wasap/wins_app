import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receivable_credit_detail_response.dart';
import 'package:meta/meta.dart';

class ReceivableCreditDetailEvent extends BlocEvent {
  ReceivableCreditDetailEvent({
    this.id,
    this.data,
    this.item,
    this.returnRequestId,
    this.returnRequestNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final int returnRequestId;
  final String returnRequestNo;
  final int itemIndex;
  final String qrResult;
}

class ReceivableCreditDetailEventNormal extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventNormal() : super();
}

class ReceivableCreditDetailEventGetId extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class ReceivableCreditDetailEventScan extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventScan({
    @required Data data,
    @required int returnRequestId,
    @required String returnRequestNo,
    @required String qrResult,
  }) : super(
          data: data,
          returnRequestId: returnRequestId,
          returnRequestNo: returnRequestNo,
          qrResult: qrResult,
        );
}

class ReceivableCreditDetailEventItemAdd extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class ReceivableCreditDetailEventItemUpdate
    extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class ReceivableCreditDetailEventItemRemove
    extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class ReceivableCreditDetailEventAdd extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceivableCreditDetailEventPost extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceivableCreditDetailEventCancel extends ReceivableCreditDetailEvent {
  ReceivableCreditDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
