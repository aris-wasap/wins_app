import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_receipt_production_response.dart';

class CflReceiptProductionEvent extends BlocEvent {
  CflReceiptProductionEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflReceiptProductionEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflReceiptProductionEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
