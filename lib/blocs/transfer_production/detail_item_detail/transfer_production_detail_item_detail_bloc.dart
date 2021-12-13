import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_production/detail_item_detail/transfer_production_detail_item_detail_event.dart';
import 'package:wins_app/blocs/transfer_production/detail_item_detail/transfer_production_detail_item_detail_state.dart';
import 'package:wins_app/models/transfer_production_detail_response.dart';

class TransferProductionDetailItemDetailBloc extends BlocEventStateBase<
    TransferProductionDetailItemDetailEvent,
    TransferProductionDetailItemDetailState> {
  TransferProductionDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState:
              TransferProductionDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<TransferProductionDetailItemDetailState> eventHandler(
      TransferProductionDetailItemDetailEvent event,
      TransferProductionDetailItemDetailState currentState) async* {
    if (event is TransferProductionDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield TransferProductionDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
