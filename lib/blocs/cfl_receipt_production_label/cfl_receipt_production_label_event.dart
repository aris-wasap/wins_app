import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_receipt_production_label_response.dart';

class CflReceiptProductionLabelEvent extends BlocEvent {
  CflReceiptProductionLabelEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflReceiptProductionLabelEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflReceiptProductionLabelEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
