import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_payable_return_request_response.dart'; 

class CflPayableReturnRequestEvent extends BlocEvent {
  CflPayableReturnRequestEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflPayableReturnRequestEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflPayableReturnRequestEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
