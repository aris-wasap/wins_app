import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/cfl_goods_issue_response.dart'; 

class CflGoodsIssueEvent extends BlocEvent {
  CflGoodsIssueEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflGoodsIssueEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflGoodsIssueEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
