import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/receipt_supplier/detail_item_detail/receipt_supplier_detail_item_detail_event.dart';
import 'package:admart_app/blocs/receipt_supplier/detail_item_detail/receipt_supplier_detail_item_detail_state.dart';
import 'package:admart_app/models/receipt_supplier_detail_response.dart';

class ReceiptSupplierDetailItemDetailBloc extends BlocEventStateBase<
    ReceiptSupplierDetailItemDetailEvent, ReceiptSupplierDetailItemDetailState> {
  ReceiptSupplierDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: ReceiptSupplierDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<ReceiptSupplierDetailItemDetailState> eventHandler(
      ReceiptSupplierDetailItemDetailEvent event,
      ReceiptSupplierDetailItemDetailState currentState) async* {
    if (event is ReceiptSupplierDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield ReceiptSupplierDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
