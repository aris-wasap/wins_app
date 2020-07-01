import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_purchase_supplier_response.dart'; 

class CflPurchaseSupplierEvent extends BlocEvent {
  CflPurchaseSupplierEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflPurchaseSupplierEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflPurchaseSupplierEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
