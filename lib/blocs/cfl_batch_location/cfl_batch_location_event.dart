import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_batch_location_response.dart';

class CflBatchLocationEvent extends BlocEvent {
  CflBatchLocationEvent(
      {this.event,
      this.searchQuery,
      this.selectedRow,
      this.whsCode,
      this.batchNo,
      this.itemCode});

  final CflBatchLocationEventType event;
  final String searchQuery;
  final Data selectedRow;
  final String whsCode;
  final String batchNo;
  final String itemCode;
}

enum CflBatchLocationEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
