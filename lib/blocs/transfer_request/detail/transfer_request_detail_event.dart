import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/transfer_request_detail_response.dart';
import 'package:meta/meta.dart';

class TransferRequestDetailEvent extends BlocEvent {
  TransferRequestDetailEvent({
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

class TransferRequestDetailEventNormal extends TransferRequestDetailEvent {
  TransferRequestDetailEventNormal() : super();
}

class TransferRequestDetailEventGetId extends TransferRequestDetailEvent {
  TransferRequestDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class TransferRequestDetailEventScan extends TransferRequestDetailEvent {
  TransferRequestDetailEventScan({
    @required Data data, 
    @required String whsCodeFrom,
    @required String qrResult,
  }) : super(
          data: data, 
          whsCodeFrom: whsCodeFrom,
          qrResult: qrResult,
        );
} 
 
class TransferRequestDetailEventItemAdd extends TransferRequestDetailEvent {
  TransferRequestDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class TransferRequestDetailEventItemUpdate extends TransferRequestDetailEvent {
  TransferRequestDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class TransferRequestDetailEventItemRemove extends TransferRequestDetailEvent { 
  TransferRequestDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}


class TransferRequestDetailEventAdd extends TransferRequestDetailEvent {
  TransferRequestDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class TransferRequestDetailEventCancel extends TransferRequestDetailEvent {
  TransferRequestDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
