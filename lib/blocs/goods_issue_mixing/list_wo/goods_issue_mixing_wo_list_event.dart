import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class GoodsIssueMixingWOListEvent extends BlocEvent {
  GoodsIssueMixingWOListEvent({
    this.event,
    this.searchQuery,
  });

  final GoodsIssueMixingWOListEventType event;
  final String searchQuery;
}

enum GoodsIssueMixingWOListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
