import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class GoodsIssueMixingListEvent extends BlocEvent {
  GoodsIssueMixingListEvent({
    this.event,
    this.searchQuery,
    this.woId,
  });

  final GoodsIssueMixingListEventType event;
  final String searchQuery;
  final int woId;
}

enum GoodsIssueMixingListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
