import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/return_sales_detail_response.dart';
import 'package:meta/meta.dart';

class ReturnSalesDetailEvent extends BlocEvent {
  ReturnSalesDetailEvent({
    this.id,
    this.data,
    this.item,
    this.doId,
    this.doNo,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final int doId;
  final String doNo;
  final int itemIndex;
  final String qrResult;
}

class ReturnSalesDetailEventNormal extends ReturnSalesDetailEvent {
  ReturnSalesDetailEventNormal() : super();
}

class ReturnSalesDetailEventGetId extends ReturnSalesDetailEvent {
  ReturnSalesDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class ReturnSalesDetailEventScan extends ReturnSalesDetailEvent {
  ReturnSalesDetailEventScan({
    @required Data data,
    @required int doId,
    @required String doNo,
    @required String qrResult,
  }) : super(
          data: data,
          doId: doId,
          doNo: doNo,
          qrResult: qrResult,
        );
}

class ReturnSalesDetailEventItemAdd extends ReturnSalesDetailEvent {
  ReturnSalesDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class ReturnSalesDetailEventItemUpdate extends ReturnSalesDetailEvent {
  ReturnSalesDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class ReturnSalesDetailEventItemRemove extends ReturnSalesDetailEvent {
  ReturnSalesDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class ReturnSalesDetailEventAdd extends ReturnSalesDetailEvent {
  ReturnSalesDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class ReturnSalesDetailEventCancel extends ReturnSalesDetailEvent {
  ReturnSalesDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
