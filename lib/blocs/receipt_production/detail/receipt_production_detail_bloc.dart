import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/receipt_production/detail/receipt_production_detail_event.dart';
import 'package:admart_app/blocs/receipt_production/detail/receipt_production_detail_state.dart';
import 'package:admart_app/models/receipt_production_detail_response.dart';
import 'package:admart_app/models/receipt_production_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/receipt_production_detail_response.dart'
    as receiptProductionDetail;

class ReceiptProductionDetailBloc extends BlocEventStateBase<
    ReceiptProductionDetailEvent, ReceiptProductionDetailState> {
  ReceiptProductionDetailBloc()
      : super(
          initialState: ReceiptProductionDetailState.noAction(),
        );

  @override
  Stream<ReceiptProductionDetailState> eventHandler(ReceiptProductionDetailEvent event,
      ReceiptProductionDetailState currentState) async* {
    if (event is ReceiptProductionDetailEventNormal) {
      yield ReceiptProductionDetailState.success(
        data: currentState.data,
      );
    } else if (event is ReceiptProductionDetailEventGetId) {
      if (event.id == 0) {
        yield ReceiptProductionDetailState.success(
          data: Data(items: List<receiptProductionDetail.Item>()),
        );
      } else {
        yield ReceiptProductionDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          ReceiptProductionDetailResponse response =
              await _repository.receiptProductionDetail_GetById(event.id);
          if (response == null) {
            yield ReceiptProductionDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield ReceiptProductionDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield ReceiptProductionDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield ReceiptProductionDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is ReceiptProductionDetailEventScan) {
      //var woId = event.woId;
      //var woNo = event.woNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield ReceiptProductionDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ReceiptProductionDetailScanResponse response =
            await _repository.receiptProductionDetail_Scan(qrResult);
        if (response == null) {
          yield ReceiptProductionDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptProductionDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield ReceiptProductionDetailState.failure(
                errorMessage: '${qrResult} sudah pernah dibuat Receipt ',
                data: event.data,
              );
            } else {
               if (response.data.itemCode == "") {
                yield ReceiptProductionDetailState.failure(
                  errorMessage: '${qrResult} tidak di temukan ',
                  data: event.data,
                );
              }
              else {
                yield ReceiptProductionDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield ReceiptProductionDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is ReceiptProductionDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield ReceiptProductionDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptProductionDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield ReceiptProductionDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptProductionDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield ReceiptProductionDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptProductionDetailEventAdd) {
      yield ReceiptProductionDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReceiptProductionDetailResponse response =
            await _repository.receiptProductionDetail_Add(event.data);
        if (response == null) {
          yield ReceiptProductionDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptProductionDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReceiptProductionDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<receiptProductionDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReceiptProductionDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReceiptProductionDetailEventCancel) {
      yield ReceiptProductionDetailState.busy(
        data: currentState.data,
      );

      yield ReceiptProductionDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
