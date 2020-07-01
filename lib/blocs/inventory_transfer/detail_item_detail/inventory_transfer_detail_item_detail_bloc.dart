import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/inventory_transfer/detail_item_detail/inventory_transfer_detail_item_detail_event.dart';
import 'package:admart_app/blocs/inventory_transfer/detail_item_detail/inventory_transfer_detail_item_detail_state.dart';
import 'package:admart_app/models/inventory_transfer_detail_response.dart';

class InventoryTransferDetailItemDetailBloc extends BlocEventStateBase<
    InventoryTransferDetailItemDetailEvent, InventoryTransferDetailItemDetailState> {
  InventoryTransferDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: InventoryTransferDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<InventoryTransferDetailItemDetailState> eventHandler(
      InventoryTransferDetailItemDetailEvent event,
      InventoryTransferDetailItemDetailState currentState) async* {
    if (event is InventoryTransferDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield InventoryTransferDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
