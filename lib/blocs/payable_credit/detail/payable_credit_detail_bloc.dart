import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/payable_credit/detail/payable_credit_detail_event.dart';
import 'package:wins_app/blocs/payable_credit/detail/payable_credit_detail_state.dart';
import 'package:wins_app/models/payable_credit_detail_response.dart';
import 'package:wins_app/models/payable_credit_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/payable_credit_detail_response.dart'
    as payableCreditDetail;

class PayableCreditDetailBloc extends BlocEventStateBase<
    PayableCreditDetailEvent, PayableCreditDetailState> {
  PayableCreditDetailBloc()
      : super(
          initialState: PayableCreditDetailState.noAction(),
        );

  @override
  Stream<PayableCreditDetailState> eventHandler(PayableCreditDetailEvent event,
      PayableCreditDetailState currentState) async* {
    if (event is PayableCreditDetailEventNormal) {
      yield PayableCreditDetailState.success(
        data: currentState.data,
      );
    } else if (event is PayableCreditDetailEventGetId) {
      if (event.id == 0) {
        yield PayableCreditDetailState.success(
          data: Data(items: List<payableCreditDetail.Item>()),
        );
      } else {
        yield PayableCreditDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          PayableCreditDetailResponse response =
              await _repository.payableCreditDetail_GetById(event.id);
          if (response == null) {
            yield PayableCreditDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield PayableCreditDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield PayableCreditDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield PayableCreditDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is PayableCreditDetailEventScan) {
      var returnRequestId = event.returnRequestId;
      var returnRequestNo = event.returnRequestNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield PayableCreditDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        PayableCreditDetailScanResponse response = await _repository
            .payableCreditDetail_Scan(returnRequestId, qrResult);
        if (response == null) {
          yield PayableCreditDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield PayableCreditDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield PayableCreditDetailState.failure(
                errorMessage:
                    'Item Batch Number ${qrResult} tidak di temukan Goods Returns Request No. ${returnRequestNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.returnRequestId == 0) {
                yield PayableCreditDetailState.failure(
                  errorMessage:
                      'Item Batch Number ${qrResult} tidak di temukan Goods Returns Request No. ${returnRequestNo} (2)',
                  data: event.data,
                );
              } else {
                yield PayableCreditDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield PayableCreditDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is PayableCreditDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield PayableCreditDetailState.success(
        data: newData,
      );
    } else if (event is PayableCreditDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield PayableCreditDetailState.success(
        data: newData,
      );
    } else if (event is PayableCreditDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield PayableCreditDetailState.success(
        data: newData,
      );
    } else if (event is PayableCreditDetailEventAdd) {
      yield PayableCreditDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        PayableCreditDetailResponse response =
            await _repository.payableCreditDetail_Add(event.data);
        if (response == null) {
          yield PayableCreditDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield PayableCreditDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield PayableCreditDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<payableCreditDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield PayableCreditDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is PayableCreditDetailEventPost) {
      yield PayableCreditDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        PayableCreditDetailResponse response =
            await _repository.payableCreditDetail_Post(event.data);
        if (response == null) {
          yield PayableCreditDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield PayableCreditDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield PayableCreditDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<payableCreditDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield PayableCreditDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is PayableCreditDetailEventCancel) {
      yield PayableCreditDetailState.busy(
        data: currentState.data,
      );

      yield PayableCreditDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
