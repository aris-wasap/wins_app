import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailItemDetailBatchEvent extends BlocEvent {
  GoodsIssueDetailItemDetailBatchEvent({
    this.data,
    this.qty,
  });

  final ItemBatch data;
  final double qty;
}

class GoodsIssueDetailItemDetailBatchEventQty
    extends GoodsIssueDetailItemDetailBatchEvent {
  GoodsIssueDetailItemDetailBatchEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
