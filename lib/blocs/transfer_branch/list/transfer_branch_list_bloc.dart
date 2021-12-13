import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_branch/list/transfer_branch_list_event.dart';
import 'package:wins_app/blocs/transfer_branch/list/transfer_branch_list_state.dart';
import 'package:wins_app/models/transfer_branch_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TransferBranchListBloc extends BlocEventStateBase<TransferBranchListEvent,
    TransferBranchListState> {
  TransferBranchListBloc()
      : super(
          initialState: TransferBranchListState.noAction(),
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
  Stream<TransferBranchListState> eventHandler(TransferBranchListEvent event,
      TransferBranchListState currentState) async* {
    switch (event.event) {
      case TransferBranchListEventType.activedSearch:
        {
          yield TransferBranchListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case TransferBranchListEventType.deactivedSearch:
        {
          yield TransferBranchListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            TransferBranchListResponse response =
                await _repository.transferBranchList_FetchNextPage(0, "");
            if (response == null) {
              yield TransferBranchListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferBranchListState.failure(
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

                yield TransferBranchListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield TransferBranchListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case TransferBranchListEventType.firstPage:
        {
          yield TransferBranchListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferBranchListResponse response = await _repository
                .transferBranchList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield TransferBranchListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferBranchListState.failure(
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
                yield TransferBranchListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferBranchListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferBranchListEventType.nextPage:
        {
          yield TransferBranchListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferBranchListResponse response =
                await _repository.transferBranchList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferBranchListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferBranchListState.failure(
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
                yield TransferBranchListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferBranchListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferBranchListEventType.refresh:
        {
          yield TransferBranchListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferBranchListResponse response =
                await _repository.transferBranchList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferBranchListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferBranchListState.failure(
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
                yield TransferBranchListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferBranchListState.failure(
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
