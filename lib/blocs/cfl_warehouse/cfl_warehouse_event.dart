import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_warehouse_response.dart'; 

class CflWarehouseEvent extends BlocEvent {
  CflWarehouseEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
    this.branchId
  });

  final CflWarehouseEventType event; 
  final String searchQuery;
  final Data selectedRow;
  final int branchId;
}

enum CflWarehouseEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
