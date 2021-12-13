import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_request/detail_item_detail/transfer_request_detail_item_detail_event.dart';
import 'package:wins_app/blocs/transfer_request/detail_item_detail/transfer_request_detail_item_detail_state.dart';
import 'package:wins_app/models/transfer_request_detail_response.dart';

class TransferRequestDetailItemDetailBloc extends BlocEventStateBase<
    TransferRequestDetailItemDetailEvent,
    TransferRequestDetailItemDetailState> {
  TransferRequestDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState:
              TransferRequestDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<TransferRequestDetailItemDetailState> eventHandler(
      TransferRequestDetailItemDetailEvent event,
      TransferRequestDetailItemDetailState currentState) async* {
    if (event is TransferRequestDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield TransferRequestDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
