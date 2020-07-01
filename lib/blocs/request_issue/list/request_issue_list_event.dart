import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class RequestIssueListEvent extends BlocEvent {
  RequestIssueListEvent({
    this.event,
    this.searchQuery,
  });

  final RequestIssueListEventType event;
  final String searchQuery;
}

enum RequestIssueListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
