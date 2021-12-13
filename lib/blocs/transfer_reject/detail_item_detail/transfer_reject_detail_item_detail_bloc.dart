import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_reject/detail_item_detail/transfer_reject_detail_item_detail_event.dart';
import 'package:wins_app/blocs/transfer_reject/detail_item_detail/transfer_reject_detail_item_detail_state.dart';
import 'package:wins_app/models/transfer_reject_detail_response.dart';

class TransferRejectDetailItemDetailBloc extends BlocEventStateBase<
    TransferRejectDetailItemDetailEvent, TransferRejectDetailItemDetailState> {
  TransferRejectDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState:
              TransferRejectDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<TransferRejectDetailItemDetailState> eventHandler(
      TransferRejectDetailItemDetailEvent event,
      TransferRejectDetailItemDetailState currentState) async* {
    if (event is TransferRejectDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield TransferRejectDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
