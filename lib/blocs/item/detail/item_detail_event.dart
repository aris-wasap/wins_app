import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/item_detail_scan_response.dart';
import 'package:meta/meta.dart';
import 'package:wins_app/models/item_detail_scan_serial_batch_number_response.dart';

class ItemDetailEvent extends BlocEvent {
  ItemDetailEvent({
    this.id,
    this.data,
    this.dataSnB,
    this.item,
    this.itemSnB,
    this.soId,
    this.soNo,
    this.itemIndex,
    this.whsCode,
    this.qrResult,
    this.itemCode,
  });

  final int id;
  final Data data;
  final DataSnB dataSnB;
  final Item item;
  final ItemSnB itemSnB;
  final int soId;
  final String soNo;
  final int itemIndex;
  final String whsCode;
  final String itemCode;
  final String qrResult;
}

class ItemDetailEventNormal extends ItemDetailEvent {
  ItemDetailEventNormal() : super();
}

class ItemDetailEventScan extends ItemDetailEvent {
  ItemDetailEventScan({
    @required Data data,
    DataSnB dataSnB,
    @required String itemCode,
    @required String qrResult,
  }) : super(
          data: data,
          dataSnB: dataSnB,
          itemCode: itemCode,
          qrResult: qrResult,
        );
}

class ItemSnBDetailEventScan extends ItemDetailEvent {
  ItemSnBDetailEventScan({
    DataSnB dataSnB,
    Data data,
    String whsCode,
    String itemCode,
    String qrResult,
  }) : super(
          dataSnB: dataSnB,
          data: data,
          whsCode: whsCode,
          itemCode: itemCode,
          qrResult: qrResult,
        );
}

class ItemDetailEventAdd extends ItemDetailEvent {
  ItemDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ItemDetailEventCancel extends ItemDetailEvent {
  ItemDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}

class ItemDetailEventClear extends ItemDetailEvent {
  ItemDetailEventClear({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ItemDetailEventClearSnB extends ItemDetailEvent {
  ItemDetailEventClearSnB({
    @required DataSnB dataSnB,
  }) : super(
          dataSnB: dataSnB,
        );
}
