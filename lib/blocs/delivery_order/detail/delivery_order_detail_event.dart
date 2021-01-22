import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/delivery_order_detail_response.dart';
import 'package:meta/meta.dart';

class DeliveryOrderDetailEvent extends BlocEvent {
  DeliveryOrderDetailEvent({
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

class DeliveryOrderDetailEventNormal extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventNormal() : super();
}

class DeliveryOrderDetailEventGetId extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class DeliveryOrderDetailEventScan extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventScan({
    @required Data data,
    @required int soId,
    @required String soNo,
    @required String qrResult,
  }) : super(
          data: data,
          soId: soId,
          soNo: soNo,
          qrResult: qrResult,
        );
}

class DeliveryOrderDetailEventItemAdd extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class DeliveryOrderDetailEventItemUpdate extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class DeliveryOrderDetailEventItemRemove extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class DeliveryOrderDetailEventAdd extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class DeliveryOrderDetailEventPost extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventPost({
    @required Data data,
  }) : super(
          data: data,
        );
}

class DeliveryOrderDetailEventCancel extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
