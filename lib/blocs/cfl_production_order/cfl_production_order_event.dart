import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_production_order_response.dart'; 

class CflProductionOrderEvent extends BlocEvent {
  CflProductionOrderEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflProductionOrderEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflProductionOrderEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
