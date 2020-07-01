import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class TransferRejectListEvent extends BlocEvent {
  TransferRejectListEvent({
    this.event,
    this.searchQuery,
  });

  final TransferRejectListEventType event;
  final String searchQuery;
}

enum TransferRejectListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
