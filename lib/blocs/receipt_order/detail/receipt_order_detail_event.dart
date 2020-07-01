import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_order_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptOrderDetailEvent extends BlocEvent {
  ReceiptOrderDetailEvent({
    this.id,
    this.data,
    this.item,
    this.poId,
    this.poNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final int poId;
  final String poNo;
  final int itemIndex;
  final String qrResult;
}

class ReceiptOrderDetailEventNormal extends ReceiptOrderDetailEvent {
  ReceiptOrderDetailEventNormal() : super();
}

class ReceiptOrderDetailEventGetId extends ReceiptOrderDetailEvent {
  ReceiptOrderDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class ReceiptOrderDetailEventScan extends ReceiptOrderDetailEvent {
  ReceiptOrderDetailEventScan({
    @required Data data,
    @required int poId,
    @required String poNo,
    @required String qrResult,
  }) : super(
          data: data,
          poId: poId,
          poNo: poNo,
          qrResult: qrResult,
        );
}

class ReceiptOrderDetailEventItemAdd extends ReceiptOrderDetailEvent {
  ReceiptOrderDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class ReceiptOrderDetailEventItemUpdate extends ReceiptOrderDetailEvent {
  ReceiptOrderDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class ReceiptOrderDetailEventItemRemove extends ReceiptOrderDetailEvent {
  ReceiptOrderDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class ReceiptOrderDetailEventAdd extends ReceiptOrderDetailEvent {
  ReceiptOrderDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceiptOrderDetailEventCancel extends ReceiptOrderDetailEvent {
  ReceiptOrderDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
