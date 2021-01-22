import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_return_request_delivery_response.dart'; 

class CflReturnRequestDeliveryEvent extends BlocEvent {
  CflReturnRequestDeliveryEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflReturnRequestDeliveryEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflReturnRequestDeliveryEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
