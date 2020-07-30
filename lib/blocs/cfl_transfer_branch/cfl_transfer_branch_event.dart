import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_transfer_branch_response.dart'; 

class CflTransferBranchEvent extends BlocEvent {
  CflTransferBranchEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflTransferBranchEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflTransferBranchEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
