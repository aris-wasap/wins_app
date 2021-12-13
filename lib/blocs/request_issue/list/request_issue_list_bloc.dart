import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/request_issue/list/request_issue_list_event.dart';
import 'package:wins_app/blocs/request_issue/list/request_issue_list_state.dart';
import 'package:wins_app/models/request_issue_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class RequestIssueListBloc
    extends BlocEventStateBase<RequestIssueListEvent, RequestIssueListState> {
  RequestIssueListBloc()
      : super(
          initialState: RequestIssueListState.noAction(),
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
  Stream<RequestIssueListState> eventHandler(
      RequestIssueListEvent event, RequestIssueListState currentState) async* {
    switch (event.event) {
      case RequestIssueListEventType.activedSearch:
        {
          yield RequestIssueListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case RequestIssueListEventType.deactivedSearch:
        {
          yield RequestIssueListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            RequestIssueListResponse response =
                await _repository.requestIssueList_FetchNextPage(0, "");
            if (response == null) {
              yield RequestIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield RequestIssueListState.failure(
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

                yield RequestIssueListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield RequestIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case RequestIssueListEventType.firstPage:
        {
          yield RequestIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            RequestIssueListResponse response = await _repository
                .requestIssueList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield RequestIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield RequestIssueListState.failure(
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
                yield RequestIssueListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield RequestIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case RequestIssueListEventType.nextPage:
        {
          yield RequestIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            RequestIssueListResponse response =
                await _repository.requestIssueList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield RequestIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield RequestIssueListState.failure(
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
                yield RequestIssueListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield RequestIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case RequestIssueListEventType.refresh:
        {
          yield RequestIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            RequestIssueListResponse response =
                await _repository.requestIssueList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield RequestIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield RequestIssueListState.failure(
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
                yield RequestIssueListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield RequestIssueListState.failure(
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
