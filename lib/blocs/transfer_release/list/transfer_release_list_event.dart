import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class TransferReleaseListEvent extends BlocEvent {
  TransferReleaseListEvent({
    this.event,
    this.searchQuery,
  });

  final TransferReleaseListEventType event;
  final String searchQuery;
}

enum TransferReleaseListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
