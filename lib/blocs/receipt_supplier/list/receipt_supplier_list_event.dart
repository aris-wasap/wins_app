import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';

class ReceiptSupplierListEvent extends BlocEvent {
  ReceiptSupplierListEvent({
    this.event,
    this.searchQuery,
  });

  final ReceiptSupplierListEventType event;
  final String searchQuery;
}

enum ReceiptSupplierListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
