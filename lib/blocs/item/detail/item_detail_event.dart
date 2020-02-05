import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/item_detail_scan_response.dart';
import 'package:meta/meta.dart';

class ItemDetailEvent extends BlocEvent {
  ItemDetailEvent({
    this.id,
    this.data,
    this.item,
    this.soId,
    this.soNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final int soId;
  final String soNo;
  final int itemIndex;
  final String qrResult;
}

class ItemDetailEventNormal extends ItemDetailEvent {
  ItemDetailEventNormal() : super();
}

class ItemDetailEventScan extends ItemDetailEvent {
  ItemDetailEventScan({
    @required Data data,
    @required String qrResult,
  }) : super(
          data: data,
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
