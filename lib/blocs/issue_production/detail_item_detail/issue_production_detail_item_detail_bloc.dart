import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/issue_production/detail_item_detail/issue_production_detail_item_detail_event.dart';
import 'package:wins_app/blocs/issue_production/detail_item_detail/issue_production_detail_item_detail_state.dart';
import 'package:wins_app/models/issue_production_detail_response.dart';

class IssueProductionDetailItemDetailBloc extends BlocEventStateBase<
    IssueProductionDetailItemDetailEvent,
    IssueProductionDetailItemDetailState> {
  IssueProductionDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState:
              IssueProductionDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<IssueProductionDetailItemDetailState> eventHandler(
      IssueProductionDetailItemDetailEvent event,
      IssueProductionDetailItemDetailState currentState) async* {
    if (event is IssueProductionDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield IssueProductionDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
