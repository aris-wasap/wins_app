import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/inventory_transfer_detail_response.dart';
import 'package:meta/meta.dart';

class InventoryTransferDetailEvent extends BlocEvent {
  InventoryTransferDetailEvent({
    this.id,
    this.data,
    this.prodOrderId,
    this.prodOrderNo,
    this.item,
    this.whsCodeFrom,
    this.itemIndex,
    this.qrResult, 
  });

  final int id;
  final Data data;
  final int prodOrderId;
  final String whsCodeFrom;
  final Item item;
  final String prodOrderNo;
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
    @required int prodOrderId,
    @required String prodOrderNo,
    @required String whsCodeFrom,
    @required String qrResult,
  }) : super(
          data: data,
          prodOrderId: prodOrderId,
          prodOrderNo: prodOrderNo,
          whsCodeFrom: whsCodeFrom,
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
