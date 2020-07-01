import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class ReceiptProductionListEvent extends BlocEvent {
  ReceiptProductionListEvent({
    this.event,
    this.searchQuery,
  });

  final ReceiptProductionListEventType event;
  final String searchQuery;
}

enum ReceiptProductionListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
