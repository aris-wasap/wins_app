import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/transfer_reject_detail_response.dart';
import 'package:meta/meta.dart';

class TransferRejectDetailEvent extends BlocEvent {
  TransferRejectDetailEvent({
    this.id,
    this.data,
    this.item,
    this.whsCodeFrom,
    this.itemIndex,
    this.qrResult, 
  });

  final int id;
  final Data data;
  final Item item;
  final String whsCodeFrom;
  final int itemIndex;
  final String qrResult; 
}

class TransferRejectDetailEventNormal extends TransferRejectDetailEvent {
  TransferRejectDetailEventNormal() : super();
}

class TransferRejectDetailEventGetId extends TransferRejectDetailEvent {
  TransferRejectDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class TransferRejectDetailEventScan extends TransferRejectDetailEvent {
  TransferRejectDetailEventScan({
    @required Data data, 
    @required String whsCodeFrom,
    @required String qrResult,
  }) : super(
          data: data, 
          whsCodeFrom: whsCodeFrom,
          qrResult: qrResult,
        );
} 
 

class TransferRejectDetailEventItemAdd extends TransferRejectDetailEvent {
  TransferRejectDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class TransferRejectDetailEventItemUpdate extends TransferRejectDetailEvent {
  TransferRejectDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class TransferRejectDetailEventItemRemove extends TransferRejectDetailEvent { 
  TransferRejectDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}


class TransferRejectDetailEventAdd extends TransferRejectDetailEvent {
  TransferRejectDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class TransferRejectDetailEventCancel extends TransferRejectDetailEvent {
  TransferRejectDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
