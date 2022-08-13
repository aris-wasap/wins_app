import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail_item_detail/goods_issue_mixing_detail_item_detail_event.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail_item_detail/goods_issue_mixing_detail_item_detail_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';

class GoodsIssueMixingDetailItemDetailBloc extends BlocEventStateBase<
    GoodsIssueMixingDetailItemDetailEvent,
    GoodsIssueMixingDetailItemDetailState> {
  GoodsIssueMixingDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState:
              GoodsIssueMixingDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsIssueMixingDetailItemDetailState> eventHandler(
      GoodsIssueMixingDetailItemDetailEvent event,
      GoodsIssueMixingDetailItemDetailState currentState) async* {
    if (event is GoodsIssueMixingDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield GoodsIssueMixingDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
