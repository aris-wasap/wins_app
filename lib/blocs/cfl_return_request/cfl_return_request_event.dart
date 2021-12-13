import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_return_request_response.dart';

class CflReturnRequestEvent extends BlocEvent {
  CflReturnRequestEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflReturnRequestEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflReturnRequestEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
