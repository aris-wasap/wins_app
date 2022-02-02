import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/inventory_transfer_detail_response.dart';
import 'package:meta/meta.dart';

class InventoryTransferDetailEvent extends BlocEvent {
  InventoryTransferDetailEvent({
    this.id,
    this.data,
    this.requestId,
    this.requestNo,
    this.whsCodeFrom,
    this.absEntryFrom,
    this.binCodeFrom,
    this.item,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final int requestId;
  final String requestNo;
  final String whsCodeFrom;
  final int absEntryFrom;
  final String binCodeFrom;
  final Item item;
  final int itemIndex;
  final String qrResult;
}

class InventoryTransferDetailEventNormal extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventNormal() : super();
}

class InventoryTransferDetailEventGetId extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class InventoryTransferDetailEventScan extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventScan({
    @required Data data,
    @required int requestId,
    @required String requestNo,
    @required String whsCodeFrom,
    @required String binCodeFrom,
    @required int absEntryFrom,
    @required String qrResult,
  }) : super(
          data: data,
          requestId: requestId,
          requestNo: requestNo,
          whsCodeFrom: whsCodeFrom,
          binCodeFrom: binCodeFrom,
          absEntryFrom: absEntryFrom,
          qrResult: qrResult,
        );
}

class InventoryTransferDetailEventItemAdd extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class InventoryTransferDetailEventItemUpdate
    extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class InventoryTransferDetailEventItemRemove
    extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class InventoryTransferDetailEventAdd extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class InventoryTransferDetailEventUpdate extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventUpdate({
    @required Data data,
  }) : super(
          data: data,
        );
}

class InventoryTransferDetailEventPost extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class InventoryTransferDetailEventCancel extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
