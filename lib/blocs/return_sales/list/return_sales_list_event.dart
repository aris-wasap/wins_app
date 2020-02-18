import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';

class ReturnSalesListEvent extends BlocEvent {
  ReturnSalesListEvent({
    this.event,
    this.searchQuery,
  });

  final ReturnSalesListEventType event;
  final String searchQuery;
}

enum ReturnSalesListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
