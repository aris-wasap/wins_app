import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class ReceiptIssueListEvent extends BlocEvent {
  ReceiptIssueListEvent({
    this.event,
    this.searchQuery,
  });

  final ReceiptIssueListEventType event;
  final String searchQuery;
}

enum ReceiptIssueListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
