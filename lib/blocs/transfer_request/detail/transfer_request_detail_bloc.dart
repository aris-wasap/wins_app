import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/transfer_request/detail/transfer_request_detail_event.dart';
import 'package:ncf_app/blocs/transfer_request/detail/transfer_request_detail_state.dart';
import 'package:ncf_app/models/transfer_request_detail_response.dart';
import 'package:ncf_app/models/transfer_request_detail_scan_response.dart';
import 'package:ncf_app/resources/repository.dart';
import 'package:ncf_app/models/transfer_request_detail_response.dart'
    as transferRequestDetail;

class TransferRequestDetailBloc extends BlocEventStateBase<
    TransferRequestDetailEvent, TransferRequestDetailState> {
  TransferRequestDetailBloc()
      : super(
          initialState: TransferRequestDetailState.noAction(),
        );

  @override
  Stream<TransferRequestDetailState> eventHandler(
      TransferRequestDetailEvent event,
      TransferRequestDetailState currentState) async* {
    if (event is TransferRequestDetailEventNormal) {
      yield TransferRequestDetailState.success(
        data: currentState.data,
      );
    } else if (event is TransferRequestDetailEventGetId) {
      if (event.id == 0) {
        yield TransferRequestDetailState.success(
          data: Data(items: List<transferRequestDetail.Item>()),
        );
      } else {
        yield TransferRequestDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          TransferRequestDetailResponse response =
              await _repository.transferRequestDetail_GetById(event.id);
          if (response == null) {
            yield TransferRequestDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield TransferRequestDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield TransferRequestDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield TransferRequestDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is TransferRequestDetailEventScan) {
      var whsCodeFrom = event.whsCodeFrom;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield TransferRequestDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        TransferRequestDetailScanResponse response =
            await _repository.transferRequestDetail_Scan(whsCodeFrom, qrResult);
        if (response == null) {
          yield TransferRequestDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferRequestDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield TransferRequestDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang ${whsCodeFrom}', 
                data: event.data,
              );
            } else {
              // if (response.data.soId == 0) {
              //   yield TransferRequestDetailState.failure(
              //     errorMessage: 'Tidak di temukan di system(2)',
              //     data: event.data,
              //   );
              // } else {
              yield TransferRequestDetailState.success(
                data: newData,
                newItem: response.data,
              );
              // }
            }
          }
        }
      } catch (e) {
        yield TransferRequestDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferRequestDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield TransferRequestDetailState.success(
        data: newData,
      );
    } else if (event is TransferRequestDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield TransferRequestDetailState.success(
        data: newData,
      );
    } else if (event is TransferRequestDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield TransferRequestDetailState.success(
        data: newData,
      );
    } else if (event is TransferRequestDetailEventAdd) {
      yield TransferRequestDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        TransferRequestDetailResponse response =
            await _repository.transferRequestDetail_Add(event.data);
        if (response == null) {
          yield TransferRequestDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferRequestDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield TransferRequestDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<transferRequestDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield TransferRequestDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferRequestDetailEventCancel) {
      yield TransferRequestDetailState.busy(
        data: currentState.data,
      );

      yield TransferRequestDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
