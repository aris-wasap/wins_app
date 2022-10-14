import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class GoodsReceiptWOListEvent extends BlocEvent {
  GoodsReceiptWOListEvent({
    this.event,
    this.searchQuery,
    this.woId,
  });

  final GoodsReceiptWOListEventType event;
  final String searchQuery;
  final int woId;
}

enum GoodsReceiptWOListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
