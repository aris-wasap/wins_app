import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class PurchaseReturnsListEvent extends BlocEvent {
  PurchaseReturnsListEvent({
    this.event,
    this.searchQuery,
  });

  final PurchaseReturnsListEventType event;
  final String searchQuery;
}

enum PurchaseReturnsListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
