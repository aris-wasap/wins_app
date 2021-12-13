import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_request/list/transfer_request_list_event.dart';
import 'package:wins_app/blocs/transfer_request/list/transfer_request_list_state.dart';
import 'package:wins_app/models/transfer_request_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TransferRequestListBloc extends BlocEventStateBase<
    TransferRequestListEvent, TransferRequestListState> {
  TransferRequestListBloc()
      : super(
          initialState: TransferRequestListState.noAction(),
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
  Stream<TransferRequestListState> eventHandler(TransferRequestListEvent event,
      TransferRequestListState currentState) async* {
    switch (event.event) {
      case TransferRequestListEventType.activedSearch:
        {
          yield TransferRequestListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case TransferRequestListEventType.deactivedSearch:
        {
          yield TransferRequestListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            TransferRequestListResponse response =
                await _repository.transferRequestList_FetchNextPage(0, "");
            if (response == null) {
              yield TransferRequestListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferRequestListState.failure(
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

                yield TransferRequestListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield TransferRequestListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case TransferRequestListEventType.firstPage:
        {
          yield TransferRequestListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferRequestListResponse response = await _repository
                .transferRequestList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield TransferRequestListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferRequestListState.failure(
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
                yield TransferRequestListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferRequestListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferRequestListEventType.nextPage:
        {
          yield TransferRequestListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferRequestListResponse response =
                await _repository.transferRequestList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferRequestListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferRequestListState.failure(
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
                yield TransferRequestListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferRequestListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferRequestListEventType.refresh:
        {
          yield TransferRequestListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferRequestListResponse response =
                await _repository.transferRequestList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferRequestListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferRequestListState.failure(
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
                yield TransferRequestListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferRequestListState.failure(
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
