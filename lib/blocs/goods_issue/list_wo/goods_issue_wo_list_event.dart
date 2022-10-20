import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class GoodsIssueWOListEvent extends BlocEvent {
  GoodsIssueWOListEvent({
    this.event,
    this.searchQuery,
    this.woId,
  });

  final GoodsIssueWOListEventType event;
  final String searchQuery;
  final int woId;
}

enum GoodsIssueWOListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
