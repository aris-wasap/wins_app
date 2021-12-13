import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class ReceivableCreditListEvent extends BlocEvent {
  ReceivableCreditListEvent({
    this.event,
    this.searchQuery,
  });

  final ReceivableCreditListEventType event;
  final String searchQuery;
}

enum ReceivableCreditListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
