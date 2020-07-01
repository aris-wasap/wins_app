import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class TransferProductionListEvent extends BlocEvent {
  TransferProductionListEvent({
    this.event,
    this.searchQuery,
  });

  final TransferProductionListEventType event;
  final String searchQuery;
}

enum TransferProductionListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
