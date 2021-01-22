import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/payable_credit_detail_response.dart';
import 'package:meta/meta.dart';

class PayableCreditDetailEvent extends BlocEvent {
  PayableCreditDetailEvent({
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

class PayableCreditDetailEventNormal extends PayableCreditDetailEvent {
  PayableCreditDetailEventNormal() : super();
}

class PayableCreditDetailEventGetId extends PayableCreditDetailEvent {
  PayableCreditDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class PayableCreditDetailEventScan extends PayableCreditDetailEvent {
  PayableCreditDetailEventScan({
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

class PayableCreditDetailEventItemAdd extends PayableCreditDetailEvent {
  PayableCreditDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class PayableCreditDetailEventItemUpdate extends PayableCreditDetailEvent {
  PayableCreditDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class PayableCreditDetailEventItemRemove extends PayableCreditDetailEvent {
  PayableCreditDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class PayableCreditDetailEventAdd extends PayableCreditDetailEvent {
  PayableCreditDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class PayableCreditDetailEventPost extends PayableCreditDetailEvent {
  PayableCreditDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class PayableCreditDetailEventCancel extends PayableCreditDetailEvent {
  PayableCreditDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
