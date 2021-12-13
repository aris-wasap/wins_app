import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_production/detail/transfer_production_detail_event.dart';
import 'package:wins_app/blocs/transfer_production/detail/transfer_production_detail_state.dart';
import 'package:wins_app/models/transfer_production_detail_response.dart';
import 'package:wins_app/models/transfer_production_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/transfer_production_detail_response.dart'
    as transferProductionDetail;

class TransferProductionDetailBloc extends BlocEventStateBase<
    TransferProductionDetailEvent, TransferProductionDetailState> {
  TransferProductionDetailBloc()
      : super(
          initialState: TransferProductionDetailState.noAction(),
        );

  @override
  Stream<TransferProductionDetailState> eventHandler(
      TransferProductionDetailEvent event,
      TransferProductionDetailState currentState) async* {
    if (event is TransferProductionDetailEventNormal) {
      yield TransferProductionDetailState.success(
        data: currentState.data,
      );
    } else if (event is TransferProductionDetailEventGetId) {
      if (event.id == 0) {
        yield TransferProductionDetailState.success(
          data: Data(items: List<transferProductionDetail.Item>()),
        );
      } else {
        yield TransferProductionDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          TransferProductionDetailResponse response =
              await _repository.transferProductionDetail_GetById(event.id);
          if (response == null) {
            yield TransferProductionDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield TransferProductionDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield TransferProductionDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield TransferProductionDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is TransferProductionDetailEventScan) {
      var woId = event.woId;
      var woNo = event.woNo;
      var fromWhsCode = event.fromWhsCode;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield TransferProductionDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        TransferProductionDetailScanResponse response = await _repository
            .transferProductionDetail_Scan(woId, fromWhsCode, qrResult);
        if (response == null) {
          yield TransferProductionDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferProductionDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield TransferProductionDetailState.failure(
                errorMessage:
                    '${qrResult} tidak di temukan di gudang ${fromWhsCode} dan production order ${woNo} ',
                data: event.data,
              );
            } else {
              // if (response.data.soId == 0) {
              //   yield TransferProductionDetailState.failure(
              //     errorMessage: 'Tidak di temukan di system(2)',
              //     data: event.data,
              //   );
              // } else {
              // newData.items.add(response.data);
              yield TransferProductionDetailState.success(
                data: newData,
                newItem: response.data,
              );
              // }
            }
          }
        }
      } catch (e) {
        yield TransferProductionDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferProductionDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield TransferProductionDetailState.success(
        data: newData,
      );
    } else if (event is TransferProductionDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield TransferProductionDetailState.success(
        data: newData,
      );
    } else if (event is TransferProductionDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield TransferProductionDetailState.success(
        data: newData,
      );
    } else if (event is TransferProductionDetailEventAdd) {
      yield TransferProductionDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        TransferProductionDetailResponse response =
            await _repository.transferProductionDetail_Add(event.data);
        if (response == null) {
          yield TransferProductionDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferProductionDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield TransferProductionDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<transferProductionDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield TransferProductionDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferProductionDetailEventCancel) {
      yield TransferProductionDetailState.busy(
        data: currentState.data,
      );

      yield TransferProductionDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
