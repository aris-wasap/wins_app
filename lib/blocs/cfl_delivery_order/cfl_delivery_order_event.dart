import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_delivery_order_response.dart'; 

class CflDeliveryOrderEvent extends BlocEvent {
  CflDeliveryOrderEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflDeliveryOrderEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflDeliveryOrderEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
