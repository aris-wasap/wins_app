import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class ReceiptBranchListEvent extends BlocEvent {
  ReceiptBranchListEvent({
    this.event,
    this.searchQuery,
  });

  final ReceiptBranchListEventType event;
  final String searchQuery;
}

enum ReceiptBranchListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
