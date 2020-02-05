import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/transfer_release/detail_item_detail/transfer_release_detail_item_detail_event.dart';
import 'package:ncf_app/blocs/transfer_release/detail_item_detail/transfer_release_detail_item_detail_state.dart';
import 'package:ncf_app/models/transfer_release_detail_response.dart';

class TransferReleaseDetailItemDetailBloc extends BlocEventStateBase<
    TransferReleaseDetailItemDetailEvent, TransferReleaseDetailItemDetailState> {
  TransferReleaseDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: TransferReleaseDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<TransferReleaseDetailItemDetailState> eventHandler(
      TransferReleaseDetailItemDetailEvent event,
      TransferReleaseDetailItemDetailState currentState) async* {
    if (event is TransferReleaseDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      yield TransferReleaseDetailItemDetailState.success(
        data: newData,
      );
    } else {}
  }
}
