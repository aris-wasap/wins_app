import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class IssueProductionListEvent extends BlocEvent {
  IssueProductionListEvent({
    this.event,
    this.searchQuery,
  });

  final IssueProductionListEventType event;
  final String searchQuery;
}

enum IssueProductionListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
