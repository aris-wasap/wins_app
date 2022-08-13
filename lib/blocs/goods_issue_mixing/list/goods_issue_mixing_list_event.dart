import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class GoodsIssueMixingListEvent extends BlocEvent {
  GoodsIssueMixingListEvent({
    this.event,
    this.searchQuery,
  });

  final GoodsIssueMixingListEventType event;
  final String searchQuery;
}

enum GoodsIssueMixingListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
