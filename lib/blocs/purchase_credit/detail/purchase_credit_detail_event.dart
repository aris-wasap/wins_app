import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/purchase_credit_detail_response.dart';
import 'package:meta/meta.dart';

class PurchaseCreditDetailEvent extends BlocEvent {
  PurchaseCreditDetailEvent({
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

class PurchaseCreditDetailEventNormal extends PurchaseCreditDetailEvent {
  PurchaseCreditDetailEventNormal() : super();
}

class PurchaseCreditDetailEventGetId extends PurchaseCreditDetailEvent {
  PurchaseCreditDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class PurchaseCreditDetailEventScan extends PurchaseCreditDetailEvent {
  PurchaseCreditDetailEventScan({
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

class PurchaseCreditDetailEventItemAdd extends PurchaseCreditDetailEvent {
  PurchaseCreditDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class PurchaseCreditDetailEventItemUpdate extends PurchaseCreditDetailEvent {
  PurchaseCreditDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class PurchaseCreditDetailEventItemRemove extends PurchaseCreditDetailEvent {
  PurchaseCreditDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class PurchaseCreditDetailEventAdd extends PurchaseCreditDetailEvent {
  PurchaseCreditDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class PurchaseCreditDetailEventCancel extends PurchaseCreditDetailEvent {
  PurchaseCreditDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
