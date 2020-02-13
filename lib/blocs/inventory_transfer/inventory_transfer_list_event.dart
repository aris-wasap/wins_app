import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';

class InventoryTransferListEvent extends BlocEvent {
  InventoryTransferListEvent({
    this.event,
    this.searchQuery,
  });

  final InventoryTransferListEventType event;
  final String searchQuery;
}

enum InventoryTransferListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
