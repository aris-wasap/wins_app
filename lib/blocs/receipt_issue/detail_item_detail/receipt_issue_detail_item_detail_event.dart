import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/receipt_issue_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptIssueDetailItemDetailEvent extends BlocEvent {
  ReceiptIssueDetailItemDetailEvent({
    this.data,
    this.qty, 
  });

  final Item data;
  final double qty; 
}

class ReceiptIssueDetailItemDetailEventQty
    extends ReceiptIssueDetailItemDetailEvent {
  ReceiptIssueDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
 