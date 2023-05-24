import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/delivery_order/detail/delivery_order_detail_event.dart';
import 'package:wins_app/blocs/delivery_order/detail/delivery_order_detail_state.dart';
import 'package:wins_app/models/delivery_order_detail_response.dart';
import 'package:wins_app/models/delivery_order_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/delivery_order_detail_response.dart'
    as deliveryOrderDetail;

class DeliveryOrderDetailBloc extends BlocEventStateBase<
    DeliveryOrderDetailEvent, DeliveryOrderDetailState> {
  DeliveryOrderDetailBloc()
      : super(
          initialState: DeliveryOrderDetailState.noAction(),
        );

  @override
  Stream<DeliveryOrderDetailState> eventHandler(DeliveryOrderDetailEvent event,
      DeliveryOrderDetailState currentState) async* {
    if (event is DeliveryOrderDetailEventNormal) {
      yield DeliveryOrderDetailState.success(
        data: currentState.data,
      );
    } else if (event is DeliveryOrderDetailEventGetId) {
      if (event.id == 0) {
        yield DeliveryOrderDetailState.success(
          data: Data(items: List<deliveryOrderDetail.Item>()),
        );
      } else {
        yield DeliveryOrderDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          DeliveryOrderDetailResponse response =
              await _repository.deliveryOrderDetail_GetById(event.id);
          if (response == null) {
            yield DeliveryOrderDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield DeliveryOrderDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield DeliveryOrderDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield DeliveryOrderDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is DeliveryOrderDetailEventScan) {
      var soId = event.soId;
      var soNo = event.soNo;
      var qrResult = event.qrResult;
      //var whsCode = event.whsCode;
      var newData = currentState.data;

      yield DeliveryOrderDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        DeliveryOrderDetailScanResponse response =
            await _repository.deliveryOrderDetail_Scan(soId, qrResult);
        if (response == null) {
          yield DeliveryOrderDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield DeliveryOrderDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield DeliveryOrderDetailState.failure(
                errorMessage:
                    'Batch Number ${qrResult} tidak di temukan dari Sales Order No. : ${soNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.soId == 0) {
                yield DeliveryOrderDetailState.failure(
                  errorMessage:
                      'Batch Number ${qrResult} tidak di temukan dari Sales Order No. : ${soNo} (2)',
                  data: event.data,
                );
              } else {
                yield DeliveryOrderDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield DeliveryOrderDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is DeliveryOrderDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield DeliveryOrderDetailState.success(
        data: newData,
      );
    } else if (event is DeliveryOrderDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield DeliveryOrderDetailState.success(
        data: newData,
      );
    } else if (event is DeliveryOrderDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield DeliveryOrderDetailState.success(
        data: newData,
      );
    } else if (event is DeliveryOrderDetailEventAdd) {
      yield DeliveryOrderDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        DeliveryOrderDetailResponse response =
            await _repository.deliveryOrderDetail_Add(event.data);
        if (response == null) {
          yield DeliveryOrderDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield DeliveryOrderDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield DeliveryOrderDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<deliveryOrderDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield DeliveryOrderDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is DeliveryOrderDetailEventUpdate) {
      yield DeliveryOrderDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        DeliveryOrderDetailResponse response =
            await _repository.deliveryOrderDetail_Update(event.data);
        if (response == null) {
          yield DeliveryOrderDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield DeliveryOrderDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield DeliveryOrderDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<deliveryOrderDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield DeliveryOrderDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is DeliveryOrderDetailEventPost) {
      yield DeliveryOrderDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        DeliveryOrderDetailResponse response =
            await _repository.deliveryOrderDetail_Post(event.data);
        if (response == null) {
          yield DeliveryOrderDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield DeliveryOrderDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield DeliveryOrderDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<deliveryOrderDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield DeliveryOrderDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is DeliveryOrderDetailEventRemoveItem) {
      yield DeliveryOrderDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        DeliveryOrderDetailResponse response = await _repository
            .deliveryOrderDetail_RemoveItem(event.id, event.detId);
        if (response == null) {
          yield DeliveryOrderDetailState.failure(
            errorMessage: 'Response null',
            data: currentState.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield DeliveryOrderDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: currentState.data,
            );
          } else {
            yield DeliveryOrderDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data,
            );
          }
        }
      } catch (e) {
        yield DeliveryOrderDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: currentState.data,
        );
      }
    } else if (event is DeliveryOrderDetailEventCancel) {
      if (event.id == 0) {
        yield DeliveryOrderDetailState.success(
          data: Data(items: List<deliveryOrderDetail.Item>()),
        );
      } else {
        yield DeliveryOrderDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          DeliveryOrderDetailResponse response =
              await _repository.deliveryOrderDetail_Cancel(event.data);
          if (response == null) {
            yield DeliveryOrderDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield DeliveryOrderDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield DeliveryOrderDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield DeliveryOrderDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else {}
  }
}
