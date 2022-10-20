import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_purchase_order_label_response.dart';

class CflPurchaseOrderLabelEvent extends BlocEvent {
  CflPurchaseOrderLabelEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflPurchaseOrderLabelEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflPurchaseOrderLabelEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
