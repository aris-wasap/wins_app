import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail/goods_issue_detail_item_detail_event.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail/goods_issue_detail_item_detail_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';

class GoodsIssueDetailItemDetailBloc extends BlocEventStateBase<
    GoodsIssueDetailItemDetailEvent, GoodsIssueDetailItemDetailState> {
  GoodsIssueDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: GoodsIssueDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsIssueDetailItemDetailState> eventHandler(
      GoodsIssueDetailItemDetailEvent event,
      GoodsIssueDetailItemDetailState currentState) async* {
    if (event is GoodsIssueDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield GoodsIssueDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
