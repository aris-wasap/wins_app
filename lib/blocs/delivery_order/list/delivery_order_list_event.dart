import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class DeliveryOrderListEvent extends BlocEvent {
  DeliveryOrderListEvent({
    this.event,
    this.searchQuery,
  });

  final DeliveryOrderListEventType event;
  final String searchQuery;
}

enum DeliveryOrderListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
