import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class GoodsIssueListEvent extends BlocEvent {
  GoodsIssueListEvent({
    this.event,
    this.searchQuery,
    this.woId,
  });

  final GoodsIssueListEventType event;
  final String searchQuery;
  final int woId;
}

enum GoodsIssueListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
