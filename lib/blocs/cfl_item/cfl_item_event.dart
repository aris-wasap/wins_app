import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_item_response.dart';

class CflItemEvent extends BlocEvent {
  CflItemEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflItemEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflItemEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
