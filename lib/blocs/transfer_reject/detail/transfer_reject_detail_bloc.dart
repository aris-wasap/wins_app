import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_reject/detail/transfer_reject_detail_event.dart';
import 'package:wins_app/blocs/transfer_reject/detail/transfer_reject_detail_state.dart';
import 'package:wins_app/models/transfer_reject_detail_response.dart';
import 'package:wins_app/models/transfer_reject_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/transfer_reject_detail_response.dart'
    as transferRejectDetail;

class TransferRejectDetailBloc extends BlocEventStateBase<
    TransferRejectDetailEvent, TransferRejectDetailState> {
  TransferRejectDetailBloc()
      : super(
          initialState: TransferRejectDetailState.noAction(),
        );

  @override
  Stream<TransferRejectDetailState> eventHandler(
      TransferRejectDetailEvent event,
      TransferRejectDetailState currentState) async* {
    if (event is TransferRejectDetailEventNormal) {
      yield TransferRejectDetailState.success(
        data: currentState.data,
      );
    } else if (event is TransferRejectDetailEventGetId) {
      if (event.id == 0) {
        yield TransferRejectDetailState.success(
          data: Data(items: List<transferRejectDetail.Item>()),
        );
      } else {
        yield TransferRejectDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          TransferRejectDetailResponse response =
              await _repository.transferRejectDetail_GetById(event.id);
          if (response == null) {
            yield TransferRejectDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield TransferRejectDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield TransferRejectDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield TransferRejectDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is TransferRejectDetailEventScan) {
      var whsCodeFrom = event.whsCodeFrom;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield TransferRejectDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        TransferRejectDetailScanResponse response =
            await _repository.transferRejectDetail_Scan(whsCodeFrom, qrResult);
        if (response == null) {
          yield TransferRejectDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferRejectDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield TransferRejectDetailState.failure(
                errorMessage:
                    '${qrResult} tidak di temukan di gudang ${whsCodeFrom}',
                data: event.data,
              );
            } else {
              // if (response.data.soId == 0) {
              //   yield TransferRejectDetailState.failure(
              //     errorMessage: 'Tidak di temukan di system(2)',
              //     data: event.data,
              //   );
              // } else {
              // newData.items.add(response.data);
              yield TransferRejectDetailState.success(
                data: newData,
                newItem: response.data,
              );
              // }
            }
          }
        }
      } catch (e) {
        yield TransferRejectDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferRejectDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield TransferRejectDetailState.success(
        data: newData,
      );
    } else if (event is TransferRejectDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield TransferRejectDetailState.success(
        data: newData,
      );
    } else if (event is TransferRejectDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield TransferRejectDetailState.success(
        data: newData,
      );
    } else if (event is TransferRejectDetailEventAdd) {
      yield TransferRejectDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        TransferRejectDetailResponse response =
            await _repository.transferRejectDetail_Add(event.data);
        if (response == null) {
          yield TransferRejectDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferRejectDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield TransferRejectDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<transferRejectDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield TransferRejectDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferRejectDetailEventCancel) {
      yield TransferRejectDetailState.busy(
        data: currentState.data,
      );

      yield TransferRejectDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
