import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/receipt_issue/list/receipt_issue_list_event.dart';
import 'package:wins_app/blocs/receipt_issue/list/receipt_issue_list_state.dart';
import 'package:wins_app/models/receipt_issue_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ReceiptIssueListBloc
    extends BlocEventStateBase<ReceiptIssueListEvent, ReceiptIssueListState> {
  ReceiptIssueListBloc()
      : super(
          initialState: ReceiptIssueListState.noAction(),
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
  Stream<ReceiptIssueListState> eventHandler(
      ReceiptIssueListEvent event, ReceiptIssueListState currentState) async* {
    switch (event.event) {
      case ReceiptIssueListEventType.activedSearch:
        {
          yield ReceiptIssueListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case ReceiptIssueListEventType.deactivedSearch:
        {
          yield ReceiptIssueListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            ReceiptIssueListResponse response =
                await _repository.receiptIssueList_FetchNextPage(0, "");
            if (response == null) {
              yield ReceiptIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptIssueListState.failure(
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

                yield ReceiptIssueListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield ReceiptIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case ReceiptIssueListEventType.firstPage:
        {
          yield ReceiptIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptIssueListResponse response = await _repository
                .receiptIssueList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield ReceiptIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptIssueListState.failure(
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
                yield ReceiptIssueListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReceiptIssueListEventType.nextPage:
        {
          yield ReceiptIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptIssueListResponse response =
                await _repository.receiptIssueList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReceiptIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptIssueListState.failure(
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
                yield ReceiptIssueListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReceiptIssueListEventType.refresh:
        {
          yield ReceiptIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptIssueListResponse response =
                await _repository.receiptIssueList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReceiptIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptIssueListState.failure(
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
                yield ReceiptIssueListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptIssueListState.failure(
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
