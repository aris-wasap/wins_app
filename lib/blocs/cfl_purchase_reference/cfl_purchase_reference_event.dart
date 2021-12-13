import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_purchase_reference_response.dart';

class CflPurchaseReferenceEvent extends BlocEvent {
  CflPurchaseReferenceEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
    this.poId,
  });

  final CflPurchaseReferenceEventType event;
  final String searchQuery;
  final Data selectedRow;
  final int poId;
}

enum CflPurchaseReferenceEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
