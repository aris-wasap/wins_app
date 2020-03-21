import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/inventory_transfer_detail_response.dart';
import 'package:meta/meta.dart';

class InventoryTransferDetailEvent extends BlocEvent {
  InventoryTransferDetailEvent({
    this.id,
    this.data,
    this.prodOrderId,
    this.prodOrderNo,
    this.whsCodeFrom,
    this.absEntryFrom,
    this.binCodeFrom,
    this.item,
    this.itemIndex,
    this.qrResult, 
  });

  final int id;
  final Data data;
  final int prodOrderId;
  final String prodOrderNo;
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
    // @required int prodOrderId,
    // @required String prodOrderNo,
    @required String whsCodeFrom,
    @required String binCodeFrom,
    @required int absEntryFrom,
    @required String qrResult,
  }) : super(
          data: data,
          // prodOrderId: prodOrderId,
          // prodOrderNo: prodOrderNo,
          whsCodeFrom: whsCodeFrom,
          binCodeFrom : binCodeFrom,
          absEntryFrom : absEntryFrom,
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

class InventoryTransferDetailEventItemUpdate extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class InventoryTransferDetailEventItemRemove extends InventoryTransferDetailEvent { 
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

class InventoryTransferDetailEventCancel extends InventoryTransferDetailEvent {
  InventoryTransferDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
