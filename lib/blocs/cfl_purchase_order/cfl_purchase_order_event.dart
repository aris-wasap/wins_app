import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/cfl_purchase_order_response.dart'; 

class CflPurchaseOrderEvent extends BlocEvent {
  CflPurchaseOrderEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflPurchaseOrderEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflPurchaseOrderEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
