import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/purchase_credit/detail_item_detail/purchase_credit_detail_item_detail_event.dart';
import 'package:admart_app/blocs/purchase_credit/detail_item_detail/purchase_credit_detail_item_detail_state.dart';
import 'package:admart_app/models/purchase_credit_detail_response.dart';

class PurchaseCreditDetailItemDetailBloc extends BlocEventStateBase<
    PurchaseCreditDetailItemDetailEvent, PurchaseCreditDetailItemDetailState> {
  PurchaseCreditDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: PurchaseCreditDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<PurchaseCreditDetailItemDetailState> eventHandler(
      PurchaseCreditDetailItemDetailEvent event,
      PurchaseCreditDetailItemDetailState currentState) async* {
    if (event is PurchaseCreditDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield PurchaseCreditDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
