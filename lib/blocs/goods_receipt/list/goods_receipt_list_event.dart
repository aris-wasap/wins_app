import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class GoodsReceiptListEvent extends BlocEvent {
  GoodsReceiptListEvent({
    this.event,
    this.searchQuery,
  });

  final GoodsReceiptListEventType event;
  final String searchQuery;
}

enum GoodsReceiptListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
