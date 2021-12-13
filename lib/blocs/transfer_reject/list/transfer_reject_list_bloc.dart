import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_reject/list/transfer_reject_list_event.dart';
import 'package:wins_app/blocs/transfer_reject/list/transfer_reject_list_state.dart';
import 'package:wins_app/models/transfer_reject_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TransferRejectListBloc extends BlocEventStateBase<TransferRejectListEvent,
    TransferRejectListState> {
  TransferRejectListBloc()
      : super(
          initialState: TransferRejectListState.noAction(),
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
  Stream<TransferRejectListState> eventHandler(TransferRejectListEvent event,
      TransferRejectListState currentState) async* {
    switch (event.event) {
      case TransferRejectListEventType.activedSearch:
        {
          yield TransferRejectListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case TransferRejectListEventType.deactivedSearch:
        {
          yield TransferRejectListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            TransferRejectListResponse response =
                await _repository.transferRejectList_FetchNextPage(0, "");
            if (response == null) {
              yield TransferRejectListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferRejectListState.failure(
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

                yield TransferRejectListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield TransferRejectListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case TransferRejectListEventType.firstPage:
        {
          yield TransferRejectListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferRejectListResponse response = await _repository
                .transferRejectList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield TransferRejectListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferRejectListState.failure(
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
                yield TransferRejectListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferRejectListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferRejectListEventType.nextPage:
        {
          yield TransferRejectListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferRejectListResponse response =
                await _repository.transferRejectList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferRejectListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferRejectListState.failure(
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
                yield TransferRejectListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferRejectListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferRejectListEventType.refresh:
        {
          yield TransferRejectListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferRejectListResponse response =
                await _repository.transferRejectList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferRejectListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferRejectListState.failure(
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
                yield TransferRejectListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferRejectListState.failure(
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
