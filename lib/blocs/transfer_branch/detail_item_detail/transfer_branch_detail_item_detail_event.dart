import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_branch_detail_response.dart';
import 'package:meta/meta.dart';

class TransferBranchDetailItemDetailEvent extends BlocEvent {
  TransferBranchDetailItemDetailEvent(
      {this.data, this.qty, this.binAbs, this.binCode});

  final Item data;
  final double qty;
  final int binAbs;
  final String binCode;
}

class TransferBranchDetailItemDetailEventQty
    extends TransferBranchDetailItemDetailEvent {
  TransferBranchDetailItemDetailEventQty({
    @required double qty,
    @required int binAbs,
    @required String binCode,
  }) : super(qty: qty, binAbs: binAbs, binCode: binCode);
}
