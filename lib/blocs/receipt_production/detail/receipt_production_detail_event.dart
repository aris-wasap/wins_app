import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_production_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptProductionDetailEvent extends BlocEvent {
  ReceiptProductionDetailEvent({
    this.id,
    this.data,
    this.item,
    this.woId,
    this.woNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final int woId;
  final String woNo;
  final int itemIndex;
  final String qrResult;
}

class ReceiptProductionDetailEventNormal extends ReceiptProductionDetailEvent {
  ReceiptProductionDetailEventNormal() : super();
}

class ReceiptProductionDetailEventGetId extends ReceiptProductionDetailEvent {
  ReceiptProductionDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class ReceiptProductionDetailEventScan extends ReceiptProductionDetailEvent {
  ReceiptProductionDetailEventScan({
    @required Data data,
    //@required int woId,
    //@required String woNo,
    @required String qrResult,
  }) : super(
          data: data,
          //woId: woId,
          //woNo: woNo,
          qrResult: qrResult,
        );
}

class ReceiptProductionDetailEventItemAdd extends ReceiptProductionDetailEvent {
  ReceiptProductionDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class ReceiptProductionDetailEventItemUpdate
    extends ReceiptProductionDetailEvent {
  ReceiptProductionDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class ReceiptProductionDetailEventItemRemove
    extends ReceiptProductionDetailEvent {
  ReceiptProductionDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class ReceiptProductionDetailEventAdd extends ReceiptProductionDetailEvent {
  ReceiptProductionDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReceiptProductionDetailEventCancel extends ReceiptProductionDetailEvent {
  ReceiptProductionDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
