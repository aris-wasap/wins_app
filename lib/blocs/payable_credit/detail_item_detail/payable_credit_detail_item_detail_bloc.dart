import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/payable_credit/detail_item_detail/payable_credit_detail_item_detail_event.dart';
import 'package:wins_app/blocs/payable_credit/detail_item_detail/payable_credit_detail_item_detail_state.dart';
import 'package:wins_app/models/payable_credit_detail_response.dart';

class PayableCreditDetailItemDetailBloc extends BlocEventStateBase<
    PayableCreditDetailItemDetailEvent, PayableCreditDetailItemDetailState> {
  PayableCreditDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: PayableCreditDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<PayableCreditDetailItemDetailState> eventHandler(
      PayableCreditDetailItemDetailEvent event,
      PayableCreditDetailItemDetailState currentState) async* {
    if (event is PayableCreditDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield PayableCreditDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
