import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_transfer_request_response.dart';

class CflTransferRequestEvent extends BlocEvent {
  CflTransferRequestEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
    this.transType,
  });

  final CflTransferRequestEventType event;
  final String searchQuery;
  final Data selectedRow;
  final String transType;
}

enum CflTransferRequestEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
