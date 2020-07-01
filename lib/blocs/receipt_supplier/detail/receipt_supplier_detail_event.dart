import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_supplier_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptSupplierDetailEvent extends BlocEvent {
  ReceiptSupplierDetailEvent({
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

class ReceiptSupplierDetailEventNormal extends ReceiptSupplierDetailEvent {
  ReceiptSupplierDetailEventNormal() : super();
}

class ReceiptSupplierDetailEventGetId extends ReceiptSupplierDetailEvent {
  ReceiptSupplierDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class ReceiptSupplierDetailEventScan extends ReceiptSupplierDetailEvent {
  ReceiptSupplierDetailEventScan({
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

class ReceiptSupplierDetailEventItemAdd extends ReceiptSupplierDetailEvent {
  ReceiptSupplierDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class ReceiptSupplierDetailEventItemUpdate extends ReceiptSupplierDetailEvent {
  ReceiptSupplierDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class ReceiptSupplierDetailEventItemRemove extends ReceiptSupplierDetailEvent {
  ReceiptSupplierDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class ReceiptSupplierDetailEventAdd extends ReceiptSupplierDetailEvent {
  ReceiptSupplierDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceiptSupplierDetailEventCancel extends ReceiptSupplierDetailEvent {
  ReceiptSupplierDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
