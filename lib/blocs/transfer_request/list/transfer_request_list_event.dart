import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class TransferRequestListEvent extends BlocEvent {
  TransferRequestListEvent({
    this.event,
    this.searchQuery,
  });

  final TransferRequestListEventType event;
  final String searchQuery;
}

enum TransferRequestListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
