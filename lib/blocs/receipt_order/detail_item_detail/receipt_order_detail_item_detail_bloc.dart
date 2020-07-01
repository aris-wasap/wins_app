import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/receipt_order/detail_item_detail/receipt_order_detail_item_detail_event.dart';
import 'package:admart_app/blocs/receipt_order/detail_item_detail/receipt_order_detail_item_detail_state.dart';
import 'package:admart_app/models/receipt_order_detail_response.dart';

class ReceiptOrderDetailItemDetailBloc extends BlocEventStateBase<
    ReceiptOrderDetailItemDetailEvent, ReceiptOrderDetailItemDetailState> {
  ReceiptOrderDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: ReceiptOrderDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<ReceiptOrderDetailItemDetailState> eventHandler(
      ReceiptOrderDetailItemDetailEvent event,
      ReceiptOrderDetailItemDetailState currentState) async* {
    if (event is ReceiptOrderDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield ReceiptOrderDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
