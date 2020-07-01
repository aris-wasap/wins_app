import 'package:admart_app/bloc_helpers/bloc_event_state.dart';

class CflDbWarehouseEvent extends BlocEvent {
  CflDbWarehouseEvent({
    this.event,
    this.searchQuery,
  });

  final CflDbWarehouseEventType event;
  final String searchQuery;
}

enum CflDbWarehouseEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
