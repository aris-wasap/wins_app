import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_production_detail_response.dart';
import 'package:meta/meta.dart';

class TransferProductionDetailEvent extends BlocEvent {
  TransferProductionDetailEvent({
    this.id,
    this.data,
    this.woId,
    this.woNo,
    this.item,
    this.fromWhsCode,
    this.itemIndex,
    this.absEntryFrom,
    this.binCodeFrom,
    this.qrResult, 
  });

  final int id;
  final Data data;
  final int woId;
  final String fromWhsCode;
  final int absEntryFrom;
  final String binCodeFrom;
  final Item item;
  final String woNo;
  final int itemIndex;
  final String qrResult; 
}

class TransferProductionDetailEventNormal extends TransferProductionDetailEvent {
  TransferProductionDetailEventNormal() : super();
}

class TransferProductionDetailEventGetId extends TransferProductionDetailEvent {
  TransferProductionDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class TransferProductionDetailEventScan extends TransferProductionDetailEvent {
  TransferProductionDetailEventScan({
    @required Data data,
    @required int woId,
    @required String woNo,
    @required String fromWhsCode,
    @required String qrResult,
  }) : super(
          data: data,
          woId: woId,
          woNo: woNo,
          fromWhsCode: fromWhsCode,
          qrResult: qrResult,
        );
} 
 

class TransferProductionDetailEventItemAdd extends TransferProductionDetailEvent {
  TransferProductionDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class TransferProductionDetailEventItemUpdate extends TransferProductionDetailEvent {
  TransferProductionDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class TransferProductionDetailEventItemRemove extends TransferProductionDetailEvent { 
  TransferProductionDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}


class TransferProductionDetailEventAdd extends TransferProductionDetailEvent {
  TransferProductionDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class TransferProductionDetailEventCancel extends TransferProductionDetailEvent {
  TransferProductionDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
