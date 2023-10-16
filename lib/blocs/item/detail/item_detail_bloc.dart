import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/item/detail/item_detail_event.dart';
import 'package:wins_app/blocs/item/detail/item_detail_state.dart';
import 'package:wins_app/models/item_detail_scan_response.dart';
import 'package:wins_app/models/item_detail_scan_serial_batch_number_response.dart';
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
      var itemCode = event.itemCode;
      var qrResult = event.qrResult;

      yield ItemDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ItemDetailScanResponse response = await _repository.itemDetail_Scan(
          itemCode,
          qrResult,
        );
        if (response == null) {
          yield ItemDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
            dataSnB: currentState.dataSnB,
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
              yield ItemDetailState.success(
                  data: response.data, dataSnB: currentState.dataSnB);
            }
          }
        }
      } catch (e) {
        yield ItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ItemSnBDetailEventScan) {
      var itemCode = event.itemCode;
      var qrResult = event.qrResult;
      var whsCode = event.whsCode;

      yield ItemDetailState.busy(
        dataSnB: currentState.dataSnB,
      );
      try {
        var _repository = Repository();
        ItemDetailScanSerialBatchNumberResponse response =
            await _repository.itemDetail_ScanSnB(whsCode, itemCode, qrResult);
        if (response == null) {
          yield ItemDetailState.failure(
            errorMessage: 'Response null',
            dataSnB: event.dataSnB,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              dataSnB: event.dataSnB,
            );
          } else {
            if (response.data == null) {
              yield ItemDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan',
                dataSnB: event.dataSnB,
              );
            } else {
              yield ItemDetailState.success(
                  dataSnB: response.data, data: currentState.data);
            }
          }
        }
      } catch (e) {
        yield ItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          dataSnB: event.dataSnB,
        );
      }
    } else if (event is ItemDetailEventCancel) {
      yield ItemDetailState.busy(
        data: currentState.data,
      );

      yield ItemDetailState.success(
        data: currentState.data,
      );
    } else if (event is ItemDetailEventClear) {
      yield ItemDetailState.busy(
        data: currentState.data,
      );
      try {
        // var _repository = Repository();
        ItemDetailScanResponse response = null;
        if (response == null) {
          yield ItemDetailState.success(
            // errorMessage: 'Response null',
            data: null,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: currentState.data,
            );
          } else {
            yield ItemDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data,
            );
          }
        }
      } catch (e) {
        yield ItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: currentState.data,
        );
      }
    } else if (event is ItemDetailEventClearSnB) {
      yield ItemDetailState.busy(
        dataSnB: currentState.dataSnB,
      );
      try {
        // var _repository = Repository();
        ItemDetailScanSerialBatchNumberResponse response = null;
        if (response == null) {
          yield ItemDetailState.success(
            // errorMessage: 'Response null',
            dataSnB: null,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              dataSnB: currentState.dataSnB,
            );
          } else {
            yield ItemDetailState.success(
              succesMessage: response.errorMessage,
              dataSnB: response.data,
            );
          }
        }
      } catch (e) {
        yield ItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: currentState.data,
        );
      }
    } else {}
  }
}
