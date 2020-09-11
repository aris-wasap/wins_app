import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/purchase_credit/detail/purchase_credit_detail_event.dart';
import 'package:admart_app/blocs/purchase_credit/detail/purchase_credit_detail_state.dart';
import 'package:admart_app/models/purchase_credit_detail_response.dart';
import 'package:admart_app/models/purchase_credit_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/purchase_credit_detail_response.dart'
    as purchaseCreditDetail;

class PurchaseCreditDetailBloc extends BlocEventStateBase<
    PurchaseCreditDetailEvent, PurchaseCreditDetailState> {
  PurchaseCreditDetailBloc()
      : super(
          initialState: PurchaseCreditDetailState.noAction(),
        );

  @override
  Stream<PurchaseCreditDetailState> eventHandler(PurchaseCreditDetailEvent event,
      PurchaseCreditDetailState currentState) async* {
    if (event is PurchaseCreditDetailEventNormal) {
      yield PurchaseCreditDetailState.success(
        data: currentState.data,
      );
    } else if (event is PurchaseCreditDetailEventGetId) {
      if (event.id == 0) {
        yield PurchaseCreditDetailState.success(
          data: Data(items: List<purchaseCreditDetail.Item>()),
        );
      } else {
        yield PurchaseCreditDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          PurchaseCreditDetailResponse response =
              await _repository.purchaseCreditDetail_GetById(event.id);
          if (response == null) {
            yield PurchaseCreditDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield PurchaseCreditDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield PurchaseCreditDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield PurchaseCreditDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is PurchaseCreditDetailEventScan) {
      var returnRequestId = event.returnRequestId;
      var returnRequestNo = event.returnRequestNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield PurchaseCreditDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        PurchaseCreditDetailScanResponse response =
            await _repository.purchaseCreditDetail_Scan(returnRequestId, qrResult);
        if (response == null) {
          yield PurchaseCreditDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield PurchaseCreditDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield PurchaseCreditDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan dan GRPO ${returnRequestNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.returnRequestId == 0) {
                yield PurchaseCreditDetailState.failure(
                  errorMessage: '${qrResult} tidak di temukan dan GRPO ${returnRequestNo} (2)',
                  data: event.data,
                );
              } else {
                yield PurchaseCreditDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield PurchaseCreditDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is PurchaseCreditDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield PurchaseCreditDetailState.success(
        data: newData,
      );
    } else if (event is PurchaseCreditDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield PurchaseCreditDetailState.success(
        data: newData,
      );
    } else if (event is PurchaseCreditDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield PurchaseCreditDetailState.success(
        data: newData,
      );
    } else if (event is PurchaseCreditDetailEventAdd) {
      yield PurchaseCreditDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        PurchaseCreditDetailResponse response =
            await _repository.purchaseCreditDetail_Add(event.data);
        if (response == null) {
          yield PurchaseCreditDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield PurchaseCreditDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield PurchaseCreditDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<purchaseCreditDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield PurchaseCreditDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is PurchaseCreditDetailEventCancel) {
      yield PurchaseCreditDetailState.busy(
        data: currentState.data,
      );

      yield PurchaseCreditDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
