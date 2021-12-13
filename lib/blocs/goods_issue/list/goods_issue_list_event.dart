import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class GoodsIssueListEvent extends BlocEvent {
  GoodsIssueListEvent({
    this.event,
    this.searchQuery,
  });

  final GoodsIssueListEventType event;
  final String searchQuery;
}

enum GoodsIssueListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
