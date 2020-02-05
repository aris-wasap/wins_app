import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/transfer_production_detail_response.dart';
import 'package:meta/meta.dart';

class TransferProductionDetailEvent extends BlocEvent {
  TransferProductionDetailEvent({
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
