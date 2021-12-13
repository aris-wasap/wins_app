import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/receivable_credit/detail_item_detail/receivable_credit_detail_item_detail_event.dart';
import 'package:wins_app/blocs/receivable_credit/detail_item_detail/receivable_credit_detail_item_detail_state.dart';
import 'package:wins_app/models/receivable_credit_detail_response.dart';

class ReceivableCreditDetailItemDetailBloc extends BlocEventStateBase<
    ReceivableCreditDetailItemDetailEvent,
    ReceivableCreditDetailItemDetailState> {
  ReceivableCreditDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState:
              ReceivableCreditDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<ReceivableCreditDetailItemDetailState> eventHandler(
      ReceivableCreditDetailItemDetailEvent event,
      ReceivableCreditDetailItemDetailState currentState) async* {
    if (event is ReceivableCreditDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield ReceivableCreditDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
