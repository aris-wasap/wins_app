import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/transfer_branch/detail_item_detail/transfer_branch_detail_item_detail_event.dart';
import 'package:admart_app/blocs/transfer_branch/detail_item_detail/transfer_branch_detail_item_detail_state.dart';
import 'package:admart_app/models/transfer_branch_detail_response.dart';

class TransferBranchDetailItemDetailBloc extends BlocEventStateBase<
    TransferBranchDetailItemDetailEvent, TransferBranchDetailItemDetailState> {
  TransferBranchDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: TransferBranchDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<TransferBranchDetailItemDetailState> eventHandler(
      TransferBranchDetailItemDetailEvent event,
      TransferBranchDetailItemDetailState currentState) async* {
    if (event is TransferBranchDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield TransferBranchDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
