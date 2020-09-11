import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class PurchaseCreditListEvent extends BlocEvent {
  PurchaseCreditListEvent({
    this.event,
    this.searchQuery,
  });

  final PurchaseCreditListEventType event;
  final String searchQuery;
}

enum PurchaseCreditListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
