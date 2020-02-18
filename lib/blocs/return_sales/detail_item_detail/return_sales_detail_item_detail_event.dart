import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/return_sales_detail_response.dart';
import 'package:meta/meta.dart';

class ReturnSalesDetailItemDetailEvent extends BlocEvent {
  ReturnSalesDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class ReturnSalesDetailItemDetailEventQty
    extends ReturnSalesDetailItemDetailEvent {
  ReturnSalesDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 