import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/receipt_branch/detail_item_detail/receipt_branch_detail_item_detail_event.dart';
import 'package:admart_app/blocs/receipt_branch/detail_item_detail/receipt_branch_detail_item_detail_state.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart';

class ReceiptBranchDetailItemDetailBloc extends BlocEventStateBase<
    ReceiptBranchDetailItemDetailEvent, ReceiptBranchDetailItemDetailState> {
  ReceiptBranchDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: ReceiptBranchDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<ReceiptBranchDetailItemDetailState> eventHandler(
      ReceiptBranchDetailItemDetailEvent event,
      ReceiptBranchDetailItemDetailState currentState) async* {
    if (event is ReceiptBranchDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield ReceiptBranchDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
