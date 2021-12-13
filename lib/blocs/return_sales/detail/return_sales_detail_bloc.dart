import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/return_sales/detail/return_sales_detail_event.dart';
import 'package:wins_app/blocs/return_sales/detail/return_sales_detail_state.dart';
import 'package:wins_app/models/return_sales_detail_response.dart';
import 'package:wins_app/models/return_sales_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/return_sales_detail_response.dart'
    as returnSalesDetail;

class ReturnSalesDetailBloc
    extends BlocEventStateBase<ReturnSalesDetailEvent, ReturnSalesDetailState> {
  ReturnSalesDetailBloc()
      : super(
          initialState: ReturnSalesDetailState.noAction(),
        );

  @override
  Stream<ReturnSalesDetailState> eventHandler(ReturnSalesDetailEvent event,
      ReturnSalesDetailState currentState) async* {
    if (event is ReturnSalesDetailEventNormal) {
      yield ReturnSalesDetailState.success(
        data: currentState.data,
      );
    } else if (event is ReturnSalesDetailEventGetId) {
      if (event.id == 0) {
        yield ReturnSalesDetailState.success(
          data: Data(items: List<returnSalesDetail.Item>()),
        );
      } else {
        yield ReturnSalesDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          ReturnSalesDetailResponse response =
              await _repository.returnSalesDetail_GetById(event.id);
          if (response == null) {
            yield ReturnSalesDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield ReturnSalesDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield ReturnSalesDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield ReturnSalesDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is ReturnSalesDetailEventScan) {
      var returnRequestId = event.returnRequestId;
      var returnRequestNo = event.returnRequestNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield ReturnSalesDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ReturnSalesDetailScanResponse response =
            await _repository.returnSalesDetail_Scan(returnRequestId, qrResult);
        if (response == null) {
          yield ReturnSalesDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReturnSalesDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield ReturnSalesDetailState.failure(
                errorMessage:
                    'Batch Number ${qrResult} tidak di temukan dari Return Request No. : ${returnRequestNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.returnRequestId == 0) {
                yield ReturnSalesDetailState.failure(
                  errorMessage:
                      'Batch Number ${qrResult} tidak di temukan dari Return Request No. : ${returnRequestNo} (2)',
                  data: event.data,
                );
              } else {
                yield ReturnSalesDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield ReturnSalesDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReturnSalesDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield ReturnSalesDetailState.success(
        data: newData,
      );
    } else if (event is ReturnSalesDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield ReturnSalesDetailState.success(
        data: newData,
      );
    } else if (event is ReturnSalesDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield ReturnSalesDetailState.success(
        data: newData,
      );
    } else if (event is ReturnSalesDetailEventAdd) {
      yield ReturnSalesDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReturnSalesDetailResponse response =
            await _repository.returnSalesDetail_Add(event.data);
        if (response == null) {
          yield ReturnSalesDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReturnSalesDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReturnSalesDetailState.success(
              succesMessage: response.errorMessage,
              data:
                  response.data ?? Data(items: List<returnSalesDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReturnSalesDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReturnSalesDetailEventPost) {
      yield ReturnSalesDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReturnSalesDetailResponse response =
            await _repository.returnSalesDetail_Post(event.data);
        if (response == null) {
          yield ReturnSalesDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReturnSalesDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReturnSalesDetailState.success(
              succesMessage: response.errorMessage,
              data:
                  response.data ?? Data(items: List<returnSalesDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReturnSalesDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReturnSalesDetailEventCancel) {
      yield ReturnSalesDetailState.busy(
        data: currentState.data,
      );

      yield ReturnSalesDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
