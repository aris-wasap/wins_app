import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class GoodsReceiptListEvent extends BlocEvent {
  GoodsReceiptListEvent({
    this.event,
    this.searchQuery,
    this.woId,
  });

  final GoodsReceiptListEventType event;
  final String searchQuery;
  final int woId;
}

enum GoodsReceiptListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
