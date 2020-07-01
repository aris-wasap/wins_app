import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/purchase_returns/detail_item_detail/purchase_returns_detail_item_detail_event.dart';
import 'package:admart_app/blocs/purchase_returns/detail_item_detail/purchase_returns_detail_item_detail_state.dart';
import 'package:admart_app/models/purchase_returns_detail_response.dart';

class PurchaseReturnsDetailItemDetailBloc extends BlocEventStateBase<
    PurchaseReturnsDetailItemDetailEvent, PurchaseReturnsDetailItemDetailState> {
  PurchaseReturnsDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: PurchaseReturnsDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<PurchaseReturnsDetailItemDetailState> eventHandler(
      PurchaseReturnsDetailItemDetailEvent event,
      PurchaseReturnsDetailItemDetailState currentState) async* {
    if (event is PurchaseReturnsDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield PurchaseReturnsDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
