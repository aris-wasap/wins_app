import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_scale_response.dart';

class CflScaleEvent extends BlocEvent {
  CflScaleEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflScaleEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflScaleEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
