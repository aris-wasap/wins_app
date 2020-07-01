import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_purchase_delivery_response.dart'; 

class CflPurchaseDeliveryEvent extends BlocEvent {
  CflPurchaseDeliveryEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflPurchaseDeliveryEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflPurchaseDeliveryEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
