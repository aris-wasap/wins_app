import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/purchase_returns/detail/purchase_returns_detail_event.dart';
import 'package:admart_app/blocs/purchase_returns/detail/purchase_returns_detail_state.dart';
import 'package:admart_app/models/purchase_returns_detail_response.dart';
import 'package:admart_app/models/purchase_returns_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/purchase_returns_detail_response.dart'
    as purchaseReturnsDetail;

class PurchaseReturnsDetailBloc extends BlocEventStateBase<
    PurchaseReturnsDetailEvent, PurchaseReturnsDetailState> {
  PurchaseReturnsDetailBloc()
      : super(
          initialState: PurchaseReturnsDetailState.noAction(),
        );

  @override
  Stream<PurchaseReturnsDetailState> eventHandler(PurchaseReturnsDetailEvent event,
      PurchaseReturnsDetailState currentState) async* {
    if (event is PurchaseReturnsDetailEventNormal) {
      yield PurchaseReturnsDetailState.success(
        data: currentState.data,
      );
    } else if (event is PurchaseReturnsDetailEventGetId) {
      if (event.id == 0) {
        yield PurchaseReturnsDetailState.success(
          data: Data(items: List<purchaseReturnsDetail.Item>()),
        );
      } else {
        yield PurchaseReturnsDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          PurchaseReturnsDetailResponse response =
              await _repository.purchaseReturnsDetail_GetById(event.id);
          if (response == null) {
            yield PurchaseReturnsDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield PurchaseReturnsDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield PurchaseReturnsDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield PurchaseReturnsDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is PurchaseReturnsDetailEventScan) {
      var grpoId = event.grpoId;
      var grpoNo = event.grpoNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield PurchaseReturnsDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        PurchaseReturnsDetailScanResponse response =
            await _repository.purchaseReturnsDetail_Scan(grpoId, qrResult);
        if (response == null) {
          yield PurchaseReturnsDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield PurchaseReturnsDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield PurchaseReturnsDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang logistic dan GRPO ${grpoNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.grpoId == 0) {
                yield PurchaseReturnsDetailState.failure(
                  errorMessage: '${qrResult} tidak di temukan di gudang logistic dan GRPO ${grpoNo} (2)',
                  data: event.data,
                );
              } else {
                yield PurchaseReturnsDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield PurchaseReturnsDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is PurchaseReturnsDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield PurchaseReturnsDetailState.success(
        data: newData,
      );
    } else if (event is PurchaseReturnsDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield PurchaseReturnsDetailState.success(
        data: newData,
      );
    } else if (event is PurchaseReturnsDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield PurchaseReturnsDetailState.success(
        data: newData,
      );
    } else if (event is PurchaseReturnsDetailEventAdd) {
      yield PurchaseReturnsDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        PurchaseReturnsDetailResponse response =
            await _repository.purchaseReturnsDetail_Add(event.data);
        if (response == null) {
          yield PurchaseReturnsDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield PurchaseReturnsDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield PurchaseReturnsDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<purchaseReturnsDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield PurchaseReturnsDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is PurchaseReturnsDetailEventCancel) {
      yield PurchaseReturnsDetailState.busy(
        data: currentState.data,
      );

      yield PurchaseReturnsDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
