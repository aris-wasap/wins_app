import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptBranchDetailItemDetailEvent extends BlocEvent {
  ReceiptBranchDetailItemDetailEvent({
    this.data,
    this.qty, 
    this.binAbs,
    this.binCode 
  });

  final Item data;
  final double qty; 
  final int binAbs;
  final String binCode; 
}

class ReceiptBranchDetailItemDetailEventQty
    extends ReceiptBranchDetailItemDetailEvent {
  ReceiptBranchDetailItemDetailEventQty({
    @required double qty,@required int binAbs,  @required String binCode,
  }) : super(
          qty: qty,
          binAbs: binAbs,
          binCode:binCode
        );
}
 