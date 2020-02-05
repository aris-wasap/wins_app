import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/transfer_release/detail/transfer_release_detail_event.dart';
import 'package:ncf_app/blocs/transfer_release/detail/transfer_release_detail_state.dart';
import 'package:ncf_app/models/transfer_release_detail_response.dart';
import 'package:ncf_app/models/transfer_release_detail_scan_response.dart';
import 'package:ncf_app/resources/repository.dart';
import 'package:ncf_app/models/transfer_release_detail_response.dart'
    as transferReleaseDetail;

class TransferReleaseDetailBloc extends BlocEventStateBase<
    TransferReleaseDetailEvent, TransferReleaseDetailState> {
  TransferReleaseDetailBloc()
      : super(
          initialState: TransferReleaseDetailState.noAction(),
        );

  @override
  Stream<TransferReleaseDetailState> eventHandler(
      TransferReleaseDetailEvent event,
      TransferReleaseDetailState currentState) async* {
    if (event is TransferReleaseDetailEventNormal) {
      yield TransferReleaseDetailState.success(
        data: currentState.data,
      );
    } else if (event is TransferReleaseDetailEventGetId) {
      if (event.id == 0) {
        yield TransferReleaseDetailState.success(
          data: Data(items: List<transferReleaseDetail.Item>()),
        );
      } else {
        yield TransferReleaseDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          TransferReleaseDetailResponse response =
              await _repository.transferReleaseDetail_GetById(event.id);
          if (response == null) {
            yield TransferReleaseDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield TransferReleaseDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield TransferReleaseDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield TransferReleaseDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is TransferReleaseDetailEventScan) {
      var whsCodeFrom = event.whsCodeFrom;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield TransferReleaseDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        TransferReleaseDetailScanResponse response =
            await _repository.transferReleaseDetail_Scan(whsCodeFrom, qrResult);
        if (response == null) {
          yield TransferReleaseDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferReleaseDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield TransferReleaseDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang ${whsCodeFrom}', 
                data: event.data,
              );
            } else {
              // if (response.data.soId == 0) {
              //   yield TransferReleaseDetailState.failure(
              //     errorMessage: 'Tidak di temukan di system(2)',
              //     data: event.data,
              //   );
              // } else {
              // newData.items.add(response.data);
              yield TransferReleaseDetailState.success(
                data: newData,
                newItem: response.data,
              );
              // }
            }
          }
        }
      } catch (e) {
        yield TransferReleaseDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferReleaseDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield TransferReleaseDetailState.success(
        data: newData,
      );
    } else if (event is TransferReleaseDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield TransferReleaseDetailState.success(
        data: newData,
      );
    } else if (event is TransferReleaseDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield TransferReleaseDetailState.success(
        data: newData,
      );
    } else if (event is TransferReleaseDetailEventAdd) {
      yield TransferReleaseDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        TransferReleaseDetailResponse response =
            await _repository.transferReleaseDetail_Add(event.data);
        if (response == null) {
          yield TransferReleaseDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferReleaseDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield TransferReleaseDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<transferReleaseDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield TransferReleaseDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferReleaseDetailEventCancel) {
      yield TransferReleaseDetailState.busy(
        data: currentState.data,
      );

      yield TransferReleaseDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
