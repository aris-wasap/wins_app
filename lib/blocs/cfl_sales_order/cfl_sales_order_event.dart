import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/cfl_sales_order_response.dart';

class CflSalesOrderEvent extends BlocEvent {
  CflSalesOrderEvent({
    this.event,
    this.searchQuery,
    this.selectedRow,
  });

  final CflSalesOrderEventType event;
  final String searchQuery;
  final Data selectedRow;
}

enum CflSalesOrderEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
