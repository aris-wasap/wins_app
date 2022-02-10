import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/item/detail/item_detail_event.dart';
import 'package:wins_app/blocs/item/detail/item_detail_state.dart';
import 'package:wins_app/models/item_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:wins_app/models/item_detail_scan_response.dart' as itemDetail;

class ItemDetailBloc
    extends BlocEventStateBase<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc()
      : super(
          initialState: ItemDetailState.noAction(),
        );

  @override
  Stream<ItemDetailState> eventHandler(
      ItemDetailEvent event, ItemDetailState currentState) async* {
    if (event is ItemDetailEventNormal) {
      yield ItemDetailState.success(
        data: currentState.data,
      );
    } else if (event is ItemDetailEventScan) {
      var qrResult = event.qrResult;

      yield ItemDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ItemDetailScanResponse response =
            await _repository.itemDetail_Scan(qrResult);
        if (response == null) {
          yield ItemDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield ItemDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan',
                data: event.data,
              );
            } else {
              yield ItemDetailState.success(data: response.data);
            }
          }
        }
      } catch (e) {
        yield ItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ItemDetailEventCancel) {
      yield ItemDetailState.busy(
        data: currentState.data,
      );

      yield ItemDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
