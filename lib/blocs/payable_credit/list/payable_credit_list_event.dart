import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class PayableCreditListEvent extends BlocEvent {
  PayableCreditListEvent({
    this.event,
    this.searchQuery,
  });

  final PayableCreditListEventType event;
  final String searchQuery;
}

enum PayableCreditListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
