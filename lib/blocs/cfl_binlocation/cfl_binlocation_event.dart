import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_binlocation_response.dart'; 

class CflBinLocationEvent extends BlocEvent {
  CflBinLocationEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
    this.whsCode
  });

  final CflBinLocationEventType event; 
  final String searchQuery;
  final Data selectedRow;
  final String whsCode;
}

enum CflBinLocationEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
