import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/goods_receipt/detail_item_detail/goods_receipt_detail_item_detail_event.dart';
import 'package:admart_app/blocs/goods_receipt/detail_item_detail/goods_receipt_detail_item_detail_state.dart';
import 'package:admart_app/models/goods_receipt_detail_response.dart';

class GoodsReceiptDetailItemDetailBloc extends BlocEventStateBase<
    GoodsReceiptDetailItemDetailEvent, GoodsReceiptDetailItemDetailState> {
  GoodsReceiptDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: GoodsReceiptDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsReceiptDetailItemDetailState> eventHandler(
      GoodsReceiptDetailItemDetailEvent event,
      GoodsReceiptDetailItemDetailState currentState) async* {
    if (event is GoodsReceiptDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield GoodsReceiptDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
