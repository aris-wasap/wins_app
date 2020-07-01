import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/return_sales/detail_item_detail/return_sales_detail_item_detail_event.dart';
import 'package:admart_app/blocs/return_sales/detail_item_detail/return_sales_detail_item_detail_state.dart';
import 'package:admart_app/models/return_sales_detail_response.dart';

class ReturnSalesDetailItemDetailBloc extends BlocEventStateBase<
    ReturnSalesDetailItemDetailEvent, ReturnSalesDetailItemDetailState> {
  ReturnSalesDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: ReturnSalesDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<ReturnSalesDetailItemDetailState> eventHandler(
      ReturnSalesDetailItemDetailEvent event,
      ReturnSalesDetailItemDetailState currentState) async* {
    if (event is ReturnSalesDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield ReturnSalesDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
