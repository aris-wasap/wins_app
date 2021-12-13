import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_purchase_item_response.dart';

class CflPurchaseItemEvent extends BlocEvent {
  CflPurchaseItemEvent(
      {this.event, this.searchQuery, this.selectedRow, this.poId});

  final CflPurchaseItemEventType event;
  final String searchQuery;
  final Data selectedRow;
  final int poId;
}

enum CflPurchaseItemEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
