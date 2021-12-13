import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_release_detail_response.dart';
import 'package:meta/meta.dart';

class TransferReleaseDetailItemDetailEvent extends BlocEvent {
  TransferReleaseDetailItemDetailEvent({
    this.data,
    this.qty,
  });

  final Item data;
  final double qty;
}

class TransferReleaseDetailItemDetailEventQty
    extends TransferReleaseDetailItemDetailEvent {
  TransferReleaseDetailItemDetailEventQty({
    @required double qty,
  }) : super(
          qty: qty,
        );
}
