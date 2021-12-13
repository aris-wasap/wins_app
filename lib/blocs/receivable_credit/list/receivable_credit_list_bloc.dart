import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/receivable_credit/list/receivable_credit_list_event.dart';
import 'package:wins_app/blocs/receivable_credit/list/receivable_credit_list_state.dart';
import 'package:wins_app/models/receivable_credit_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ReceivableCreditListBloc extends BlocEventStateBase<
    ReceivableCreditListEvent, ReceivableCreditListState> {
  ReceivableCreditListBloc()
      : super(
          initialState: ReceivableCreditListState.noAction(),
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
  Stream<ReceivableCreditListState> eventHandler(
      ReceivableCreditListEvent event,
      ReceivableCreditListState currentState) async* {
    switch (event.event) {
      case ReceivableCreditListEventType.activedSearch:
        {
          yield ReceivableCreditListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case ReceivableCreditListEventType.deactivedSearch:
        {
          yield ReceivableCreditListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            ReceivableCreditListResponse response =
                await _repository.receivableCreditList_FetchNextPage(0, "");
            if (response == null) {
              yield ReceivableCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceivableCreditListState.failure(
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

                yield ReceivableCreditListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield ReceivableCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case ReceivableCreditListEventType.firstPage:
        {
          yield ReceivableCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceivableCreditListResponse response = await _repository
                .receivableCreditList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield ReceivableCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceivableCreditListState.failure(
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
                yield ReceivableCreditListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceivableCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReceivableCreditListEventType.nextPage:
        {
          yield ReceivableCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceivableCreditListResponse response =
                await _repository.receivableCreditList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReceivableCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceivableCreditListState.failure(
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
                yield ReceivableCreditListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceivableCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReceivableCreditListEventType.refresh:
        {
          yield ReceivableCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceivableCreditListResponse response =
                await _repository.receivableCreditList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReceivableCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceivableCreditListState.failure(
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
                yield ReceivableCreditListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceivableCreditListState.failure(
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
