import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/return_sales/list/return_sales_list_event.dart';
import 'package:ncf_app/blocs/return_sales/list/return_sales_list_state.dart';
import 'package:ncf_app/models/return_sales_list_response.dart';
import 'package:ncf_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ReturnSalesListBloc
    extends BlocEventStateBase<ReturnSalesListEvent, ReturnSalesListState> {
  ReturnSalesListBloc()
      : super(
          initialState: ReturnSalesListState.noAction(),
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
  Stream<ReturnSalesListState> eventHandler(ReturnSalesListEvent event,
      ReturnSalesListState currentState) async* {
    switch (event.event) {
      case ReturnSalesListEventType.activedSearch:
        {
          yield ReturnSalesListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case ReturnSalesListEventType.deactivedSearch:
        {
          yield ReturnSalesListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            ReturnSalesListResponse response =
                await _repository.returnSalesList_FetchNextPage(0, "");
            if (response == null) {
              yield ReturnSalesListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield ReturnSalesListState.failure(
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

                yield ReturnSalesListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield ReturnSalesListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case ReturnSalesListEventType.firstPage:
        {
          yield ReturnSalesListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReturnSalesListResponse response = await _repository
                .returnSalesList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield ReturnSalesListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReturnSalesListState.failure(
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
                yield ReturnSalesListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReturnSalesListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReturnSalesListEventType.nextPage:
        {
          yield ReturnSalesListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReturnSalesListResponse response =
                await _repository.returnSalesList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReturnSalesListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReturnSalesListState.failure(
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
                yield ReturnSalesListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReturnSalesListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReturnSalesListEventType.refresh:
        {
          yield ReturnSalesListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReturnSalesListResponse response =
                await _repository.returnSalesList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReturnSalesListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReturnSalesListState.failure(
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
                yield ReturnSalesListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReturnSalesListState.failure(
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
