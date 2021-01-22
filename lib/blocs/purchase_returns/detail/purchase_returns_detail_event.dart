import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/purchase_returns_detail_response.dart';
import 'package:meta/meta.dart';

class PurchaseReturnsDetailEvent extends BlocEvent {
  PurchaseReturnsDetailEvent({
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

class PurchaseReturnsDetailEventNormal extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventNormal() : super();
}

class PurchaseReturnsDetailEventGetId extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class PurchaseReturnsDetailEventScan extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventScan({
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

class PurchaseReturnsDetailEventItemAdd extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class PurchaseReturnsDetailEventItemUpdate extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class PurchaseReturnsDetailEventItemRemove extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class PurchaseReturnsDetailEventAdd extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class PurchaseReturnsDetailEventPost extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class PurchaseReturnsDetailEventCancel extends PurchaseReturnsDetailEvent {
  PurchaseReturnsDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
