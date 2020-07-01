import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailItemDetailEvent extends BlocEvent {
  GoodsIssueDetailItemDetailEvent({
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

class GoodsIssueDetailItemDetailEventQty
    extends GoodsIssueDetailItemDetailEvent {
  GoodsIssueDetailItemDetailEventQty({
    @required double qty,@required int binAbs,  @required String binCode,
  }) : super(
          qty: qty,
          binAbs: binAbs,
          binCode:binCode
        );
}
 