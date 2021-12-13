import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_request_branch_response.dart';

class CflRequestBranchEvent extends BlocEvent {
  CflRequestBranchEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflRequestBranchEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflRequestBranchEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
