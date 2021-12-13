import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_item_batch_response.dart';

class CflItemBatchEvent extends BlocEvent {
  CflItemBatchEvent(
      {this.event,
      this.searchQuery,
      this.selectedRow,
      this.whsCode,
      this.batchNo,
      this.id});

  final CflItemBatchEventType event;
  final String searchQuery;
  final Data selectedRow;
  final String whsCode;
  final String batchNo;
  final int id;
}

enum CflItemBatchEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
