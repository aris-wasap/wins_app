import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_branch_response.dart'; 

class CflBranchEvent extends BlocEvent {
  CflBranchEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
    this.branchId
  });

  final CflBranchEventType event; 
  final String searchQuery;
  final Data selectedRow;
  final int branchId;
}

enum CflBranchEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
