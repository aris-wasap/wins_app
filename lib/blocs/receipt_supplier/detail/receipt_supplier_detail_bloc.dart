import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/receipt_supplier/detail/receipt_supplier_detail_event.dart';
import 'package:admart_app/blocs/receipt_supplier/detail/receipt_supplier_detail_state.dart';
import 'package:admart_app/models/receipt_supplier_detail_response.dart';
import 'package:admart_app/models/receipt_supplier_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/receipt_supplier_detail_response.dart'
    as receiptSupplierDetail;

class ReceiptSupplierDetailBloc extends BlocEventStateBase<
    ReceiptSupplierDetailEvent, ReceiptSupplierDetailState> {
  ReceiptSupplierDetailBloc()
      : super(
          initialState: ReceiptSupplierDetailState.noAction(),
        );

  @override
  Stream<ReceiptSupplierDetailState> eventHandler(ReceiptSupplierDetailEvent event,
      ReceiptSupplierDetailState currentState) async* {
    if (event is ReceiptSupplierDetailEventNormal) {
      yield ReceiptSupplierDetailState.success(
        data: currentState.data,
      );
    } else if (event is ReceiptSupplierDetailEventGetId) {
      if (event.id == 0) {
        yield ReceiptSupplierDetailState.success(
          data: Data(items: List<receiptSupplierDetail.Item>()),
        );
      } else {
        yield ReceiptSupplierDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          ReceiptSupplierDetailResponse response =
              await _repository.receiptSupplierDetail_GetById(event.id);
          if (response == null) {
            yield ReceiptSupplierDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield ReceiptSupplierDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield ReceiptSupplierDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield ReceiptSupplierDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is ReceiptSupplierDetailEventScan) {
      var poId = event.poId;
      var poNo = event.poNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield ReceiptSupplierDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ReceiptSupplierDetailScanResponse response =
            await _repository.receiptSupplierDetail_Scan(poId, qrResult);
        if (response == null) {
          yield ReceiptSupplierDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptSupplierDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield ReceiptSupplierDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang logistic dan PO ${poNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.poId == 0) {
                yield ReceiptSupplierDetailState.failure(
                  errorMessage: '${qrResult} tidak di temukan di gudang logistic dan PO ${poNo} (2)',
                  data: event.data,
                );
              } else {
                yield ReceiptSupplierDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield ReceiptSupplierDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is ReceiptSupplierDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield ReceiptSupplierDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptSupplierDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield ReceiptSupplierDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptSupplierDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield ReceiptSupplierDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptSupplierDetailEventAdd) {
      yield ReceiptSupplierDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReceiptSupplierDetailResponse response =
            await _repository.receiptSupplierDetail_Add(event.data);
        if (response == null) {
          yield ReceiptSupplierDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptSupplierDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReceiptSupplierDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<receiptSupplierDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReceiptSupplierDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReceiptSupplierDetailEventCancel) {
      yield ReceiptSupplierDetailState.busy(
        data: currentState.data,
      );

      yield ReceiptSupplierDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
