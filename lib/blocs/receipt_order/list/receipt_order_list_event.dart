import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class ReceiptOrderListEvent extends BlocEvent {
  ReceiptOrderListEvent({
    this.event,
    this.searchQuery,
  });

  final ReceiptOrderListEventType event;
  final String searchQuery;
}

enum ReceiptOrderListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
