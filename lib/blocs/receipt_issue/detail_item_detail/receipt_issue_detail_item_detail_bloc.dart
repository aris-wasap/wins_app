import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/receipt_issue/detail_item_detail/receipt_issue_detail_item_detail_event.dart';
import 'package:wins_app/blocs/receipt_issue/detail_item_detail/receipt_issue_detail_item_detail_state.dart';
import 'package:wins_app/models/receipt_issue_detail_response.dart';

class ReceiptIssueDetailItemDetailBloc extends BlocEventStateBase<
    ReceiptIssueDetailItemDetailEvent, ReceiptIssueDetailItemDetailState> {
  ReceiptIssueDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: ReceiptIssueDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<ReceiptIssueDetailItemDetailState> eventHandler(
      ReceiptIssueDetailItemDetailEvent event,
      ReceiptIssueDetailItemDetailState currentState) async* {
    if (event is ReceiptIssueDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield ReceiptIssueDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
