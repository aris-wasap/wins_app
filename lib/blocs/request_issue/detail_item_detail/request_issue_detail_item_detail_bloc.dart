import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/request_issue/detail_item_detail/request_issue_detail_item_detail_event.dart';
import 'package:admart_app/blocs/request_issue/detail_item_detail/request_issue_detail_item_detail_state.dart';
import 'package:admart_app/models/request_issue_detail_response.dart';

class RequestIssueDetailItemDetailBloc extends BlocEventStateBase<
    RequestIssueDetailItemDetailEvent, RequestIssueDetailItemDetailState> {
  RequestIssueDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: RequestIssueDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<RequestIssueDetailItemDetailState> eventHandler(
      RequestIssueDetailItemDetailEvent event,
      RequestIssueDetailItemDetailState currentState) async* {
    if (event is RequestIssueDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield RequestIssueDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
