import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail_batch/goods_issue_detail_item_detail_batch_event.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail_batch/goods_issue_detail_item_detail_batch_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';

class GoodsIssueDetailItemDetailBatchBloc extends BlocEventStateBase<
    GoodsIssueDetailItemDetailBatchEvent,
    GoodsIssueDetailItemDetailBatchState> {
  GoodsIssueDetailItemDetailBatchBloc(
    ItemBatch data,
  ) : super(
          initialState:
              GoodsIssueDetailItemDetailBatchState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsIssueDetailItemDetailBatchState> eventHandler(
      GoodsIssueDetailItemDetailBatchEvent event,
      GoodsIssueDetailItemDetailBatchState currentState) async* {
    if (event is GoodsIssueDetailItemDetailBatchEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.quantity = event.qty;
      yield GoodsIssueDetailItemDetailBatchState.success(
        data: newData,
      );
    } else {}
  }
}
