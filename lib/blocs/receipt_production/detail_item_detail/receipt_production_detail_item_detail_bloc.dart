import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/receipt_production/detail_item_detail/receipt_production_detail_item_detail_event.dart';
import 'package:ncf_app/blocs/receipt_production/detail_item_detail/receipt_production_detail_item_detail_state.dart';
import 'package:ncf_app/models/receipt_production_detail_response.dart';

class ReceiptProductionDetailItemDetailBloc extends BlocEventStateBase<
    ReceiptProductionDetailItemDetailEvent, ReceiptProductionDetailItemDetailState> {
  ReceiptProductionDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: ReceiptProductionDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<ReceiptProductionDetailItemDetailState> eventHandler(
      ReceiptProductionDetailItemDetailEvent event,
      ReceiptProductionDetailItemDetailState currentState) async* {
    if (event is ReceiptProductionDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.quantity = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield ReceiptProductionDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
