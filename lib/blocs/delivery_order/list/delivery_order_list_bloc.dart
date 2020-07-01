import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/delivery_order/list/delivery_order_list_event.dart';
import 'package:admart_app/blocs/delivery_order/list/delivery_order_list_state.dart';
import 'package:admart_app/models/delivery_order_list_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DeliveryOrderListBloc
    extends BlocEventStateBase<DeliveryOrderListEvent, DeliveryOrderListState> {
  DeliveryOrderListBloc()
      : super(
          initialState: DeliveryOrderListState.noAction(),
        );

  final BehaviorSubject<int> _firstIdController =
      BehaviorSubject<int>(seedValue: 0);
  final BehaviorSubject<int> _lastIdController = BehaviorSubject<int>(seedValue: 0);

  @override
  void dispose() {
    _firstIdController.close();
    _lastIdController.close();

    super.dispose();
  }

  @override
  Stream<DeliveryOrderListState> eventHandler(DeliveryOrderListEvent event,
      DeliveryOrderListState currentState) async* {
    switch (event.event) {
      case DeliveryOrderListEventType.activedSearch:
        {
          yield DeliveryOrderListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case DeliveryOrderListEventType.deactivedSearch:
        {
          yield DeliveryOrderListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            DeliveryOrderListResponse response =
                await _repository.deliveryOrderList_FetchNextPage(0, "");
            if (response == null) {
              yield DeliveryOrderListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield DeliveryOrderListState.failure(
                    errorMessage: 'Fetch fail ${response.errorMessage}',
                    data: currentState.data,
                    isActiveSearch: false);
              } else {
                if (response.data.length == 0) {
                  _firstIdController.value = 0;
                  _lastIdController.value = 0;
                } else {
                  _firstIdController.value = response.data[0].id;
                  _lastIdController.value =
                      response.data[response.data.length - 1].id;
                }

                yield DeliveryOrderListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield DeliveryOrderListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case DeliveryOrderListEventType.firstPage:
        {
          yield DeliveryOrderListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            DeliveryOrderListResponse response = await _repository
                .deliveryOrderList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield DeliveryOrderListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield DeliveryOrderListState.failure(
                    errorMessage: 'Fetch fail ${response.errorMessage}',
                    data: currentState.data,
                    isActiveSearch: currentState.isActiveSearch);
              } else {
                if (response.data.length == 0) {
                  _firstIdController.value = 0;
                  _lastIdController.value = 0;
                } else {
                  _firstIdController.value = response.data[0].id;
                  _lastIdController.value =
                      response.data[response.data.length - 1].id;
                }
                yield DeliveryOrderListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield DeliveryOrderListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case DeliveryOrderListEventType.nextPage:
        {
          yield DeliveryOrderListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            DeliveryOrderListResponse response =
                await _repository.deliveryOrderList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield DeliveryOrderListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield DeliveryOrderListState.failure(
                    errorMessage: 'Fetch fail ${response.errorMessage}',
                    data: currentState.data,
                    isActiveSearch: currentState.isActiveSearch);
              } else {
                if (response.data.length == 0) {
                } else {
                  _lastIdController.value =
                      response.data[response.data.length - 1].id;
                }

                var data = currentState.data;
                data.addAll(response.data);
                yield DeliveryOrderListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield DeliveryOrderListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case DeliveryOrderListEventType.refresh:
        {
          yield DeliveryOrderListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            DeliveryOrderListResponse response =
                await _repository.deliveryOrderList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield DeliveryOrderListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield DeliveryOrderListState.failure(
                    errorMessage: 'Fetch fail ${response.errorMessage}',
                    data: currentState.data,
                    isActiveSearch: currentState.isActiveSearch);
              } else {
                if (response.data.length == 0) {
                  _firstIdController.value = 0;
                  _lastIdController.value = 0;
                } else {
                  _firstIdController.value = response.data[0].id;
                  _lastIdController.value =
                      response.data[response.data.length - 1].id;
                }
                yield DeliveryOrderListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield DeliveryOrderListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      default:
        {}
    }
  }
}
