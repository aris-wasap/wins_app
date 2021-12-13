import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/receivable_credit/detail/receivable_credit_detail_event.dart';
import 'package:wins_app/blocs/receivable_credit/detail/receivable_credit_detail_state.dart';
import 'package:wins_app/models/receivable_credit_detail_response.dart';
import 'package:wins_app/models/receivable_credit_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/receivable_credit_detail_response.dart'
    as receivableCreditDetail;

class ReceivableCreditDetailBloc extends BlocEventStateBase<
    ReceivableCreditDetailEvent, ReceivableCreditDetailState> {
  ReceivableCreditDetailBloc()
      : super(
          initialState: ReceivableCreditDetailState.noAction(),
        );

  @override
  Stream<ReceivableCreditDetailState> eventHandler(
      ReceivableCreditDetailEvent event,
      ReceivableCreditDetailState currentState) async* {
    if (event is ReceivableCreditDetailEventNormal) {
      yield ReceivableCreditDetailState.success(
        data: currentState.data,
      );
    } else if (event is ReceivableCreditDetailEventGetId) {
      if (event.id == 0) {
        yield ReceivableCreditDetailState.success(
          data: Data(items: List<receivableCreditDetail.Item>()),
        );
      } else {
        yield ReceivableCreditDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          ReceivableCreditDetailResponse response =
              await _repository.receivableCreditDetail_GetById(event.id);
          if (response == null) {
            yield ReceivableCreditDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield ReceivableCreditDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield ReceivableCreditDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield ReceivableCreditDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is ReceivableCreditDetailEventScan) {
      var returnRequestId = event.returnRequestId;
      var returnRequestNo = event.returnRequestNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield ReceivableCreditDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ReceivableCreditDetailScanResponse response = await _repository
            .receivableCreditDetail_Scan(returnRequestId, qrResult);
        if (response == null) {
          yield ReceivableCreditDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceivableCreditDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield ReceivableCreditDetailState.failure(
                errorMessage:
                    'Batch Number ${qrResult} tidak di temukan dari Return Request No. : ${returnRequestNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.returnRequestId == 0) {
                yield ReceivableCreditDetailState.failure(
                  errorMessage:
                      'Batch Number ${qrResult} tidak di temukan dari Return Request No. : ${returnRequestNo} (2)',
                  data: event.data,
                );
              } else {
                yield ReceivableCreditDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield ReceivableCreditDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReceivableCreditDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield ReceivableCreditDetailState.success(
        data: newData,
      );
    } else if (event is ReceivableCreditDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield ReceivableCreditDetailState.success(
        data: newData,
      );
    } else if (event is ReceivableCreditDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield ReceivableCreditDetailState.success(
        data: newData,
      );
    } else if (event is ReceivableCreditDetailEventAdd) {
      yield ReceivableCreditDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReceivableCreditDetailResponse response =
            await _repository.receivableCreditDetail_Add(event.data);
        if (response == null) {
          yield ReceivableCreditDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceivableCreditDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReceivableCreditDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<receivableCreditDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReceivableCreditDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReceivableCreditDetailEventPost) {
      yield ReceivableCreditDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReceivableCreditDetailResponse response =
            await _repository.receivableCreditDetail_Post(event.data);
        if (response == null) {
          yield ReceivableCreditDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceivableCreditDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReceivableCreditDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<receivableCreditDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReceivableCreditDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReceivableCreditDetailEventCancel) {
      yield ReceivableCreditDetailState.busy(
        data: currentState.data,
      );

      yield ReceivableCreditDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
