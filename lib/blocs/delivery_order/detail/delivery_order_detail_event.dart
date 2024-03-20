import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/delivery_order_detail_response.dart';
import 'package:meta/meta.dart';

class DeliveryOrderDetailEvent extends BlocEvent {
  DeliveryOrderDetailEvent(
      {this.id,
      this.detId,
      this.data,
      this.item,
      this.soId,
      this.soNo,
      this.itemIndex,
      this.qrResult,
      this.whsCode});

  final int id;
  final int detId;
  final Data data;
  final Item item;
  final int soId;
  final String soNo;
  final int itemIndex;
  final String qrResult;
  final String whsCode;
}

class DeliveryOrderDetailEventNormal extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventNormal() : super();
}

class DeliveryOrderDetailEventGetAllData extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventGetAllData({
    @required int id,
  }) : super(
          id: id,
        );
}

class DeliveryOrderDetailEventGetId extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class DeliveryOrderDetailEventScan extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventScan(
      {@required Data data,
      @required int soId,
      @required String soNo,
      @required String qrResult})
      : super(
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

class DeliveryOrderDetailEventUpdate extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventUpdate({
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
    @required Data data,
  }) : super(
          id: id,
          data: data,
        );
}

class DeliveryOrderDetailEventRemoveItem extends DeliveryOrderDetailEvent {
  DeliveryOrderDetailEventRemoveItem({
    @required int id,
    @required int detId,
  }) : super(id: id, detId: detId);
}
