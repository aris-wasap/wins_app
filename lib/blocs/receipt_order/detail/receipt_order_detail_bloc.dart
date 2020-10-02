import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/receipt_order/detail/receipt_order_detail_event.dart';
import 'package:admart_app/blocs/receipt_order/detail/receipt_order_detail_state.dart';
import 'package:admart_app/models/receipt_order_detail_response.dart';
import 'package:admart_app/models/receipt_order_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/receipt_order_detail_response.dart'
    as receiptOrderDetail;

class ReceiptOrderDetailBloc extends BlocEventStateBase<
    ReceiptOrderDetailEvent, ReceiptOrderDetailState> {
  ReceiptOrderDetailBloc()
      : super(
          initialState: ReceiptOrderDetailState.noAction(),
        );

  @override
  Stream<ReceiptOrderDetailState> eventHandler(ReceiptOrderDetailEvent event,
      ReceiptOrderDetailState currentState) async* {
    if (event is ReceiptOrderDetailEventNormal) {
      yield ReceiptOrderDetailState.success(
        data: currentState.data,
      );
    } else if (event is ReceiptOrderDetailEventGetId) {
      if (event.id == 0) {
        yield ReceiptOrderDetailState.success(
          data: Data(items: List<receiptOrderDetail.Item>()),
        );
      } else {
        yield ReceiptOrderDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          ReceiptOrderDetailResponse response =
              await _repository.receiptOrderDetail_GetById(event.id);
          if (response == null) {
            yield ReceiptOrderDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield ReceiptOrderDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield ReceiptOrderDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield ReceiptOrderDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is ReceiptOrderDetailEventScan) {
      var poId = event.poId;
      var poNo = event.poNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield ReceiptOrderDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ReceiptOrderDetailScanResponse response =
            await _repository.receiptOrderDetail_Scan(poId, qrResult);
        if (response == null) {
          yield ReceiptOrderDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptOrderDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield ReceiptOrderDetailState.failure(
                errorMessage: 'Item Batch Number ${qrResult} tidak di temukan  PO ${poNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.poId == 0) {
                yield ReceiptOrderDetailState.failure(
                  errorMessage: 'Item Batch Number ${qrResult} tidak di temukan  PO ${poNo} (2)',
                  data: event.data,
                );
              } else {
                yield ReceiptOrderDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield ReceiptOrderDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is ReceiptOrderDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield ReceiptOrderDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptOrderDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield ReceiptOrderDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptOrderDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield ReceiptOrderDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptOrderDetailEventAdd) {
      yield ReceiptOrderDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReceiptOrderDetailResponse response =
            await _repository.receiptOrderDetail_Add(event.data);
        if (response == null) {
          yield ReceiptOrderDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptOrderDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReceiptOrderDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<receiptOrderDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReceiptOrderDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }
    else if (event is ReceiptOrderDetailEventPost) {
      yield ReceiptOrderDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReceiptOrderDetailResponse response =
            await _repository.receiptOrderDetail_Post(event.data);
        if (response == null) {
          yield ReceiptOrderDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptOrderDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReceiptOrderDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<receiptOrderDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReceiptOrderDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is ReceiptOrderDetailEventCancel) {
      yield ReceiptOrderDetailState.busy(
        data: currentState.data,
      );

      yield ReceiptOrderDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
