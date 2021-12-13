import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/payable_credit/list/payable_credit_list_event.dart';
import 'package:wins_app/blocs/payable_credit/list/payable_credit_list_state.dart';
import 'package:wins_app/models/payable_credit_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PayableCreditListBloc
    extends BlocEventStateBase<PayableCreditListEvent, PayableCreditListState> {
  PayableCreditListBloc()
      : super(
          initialState: PayableCreditListState.noAction(),
        );

  final BehaviorSubject<int> _firstIdController =
      BehaviorSubject<int>(seedValue: 0);
  final BehaviorSubject<int> _lastIdController =
      BehaviorSubject<int>(seedValue: 0);

  @override
  void dispose() {
    _firstIdController.close();
    _lastIdController.close();

    super.dispose();
  }

  @override
  Stream<PayableCreditListState> eventHandler(PayableCreditListEvent event,
      PayableCreditListState currentState) async* {
    switch (event.event) {
      case PayableCreditListEventType.activedSearch:
        {
          yield PayableCreditListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case PayableCreditListEventType.deactivedSearch:
        {
          yield PayableCreditListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            PayableCreditListResponse response =
                await _repository.payableCreditList_FetchNextPage(0, "");
            if (response == null) {
              yield PayableCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield PayableCreditListState.failure(
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

                yield PayableCreditListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield PayableCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case PayableCreditListEventType.firstPage:
        {
          yield PayableCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PayableCreditListResponse response = await _repository
                .payableCreditList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield PayableCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PayableCreditListState.failure(
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
                yield PayableCreditListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PayableCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case PayableCreditListEventType.nextPage:
        {
          yield PayableCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PayableCreditListResponse response =
                await _repository.payableCreditList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield PayableCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PayableCreditListState.failure(
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
                yield PayableCreditListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PayableCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case PayableCreditListEventType.refresh:
        {
          yield PayableCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PayableCreditListResponse response =
                await _repository.payableCreditList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield PayableCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PayableCreditListState.failure(
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
                yield PayableCreditListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PayableCreditListState.failure(
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
