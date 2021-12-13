import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_transfer_production_response.dart';

class CflTransferProductionEvent extends BlocEvent {
  CflTransferProductionEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflTransferProductionEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflTransferProductionEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
