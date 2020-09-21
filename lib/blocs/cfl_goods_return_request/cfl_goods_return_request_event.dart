import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/cfl_goods_return_request_response.dart'; 

class CflGoodsReturnRequestEvent extends BlocEvent {
  CflGoodsReturnRequestEvent({
    this.event, 
    this.searchQuery,
    this.selectedRow,
  });

  final CflGoodsReturnRequestEventType event; 
  final String searchQuery;
  final Data selectedRow;
}

enum CflGoodsReturnRequestEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
  selectedRow,
}
