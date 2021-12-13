import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/receipt_branch/list/receipt_branch_list_event.dart';
import 'package:wins_app/blocs/receipt_branch/list/receipt_branch_list_state.dart';
import 'package:wins_app/models/receipt_branch_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ReceiptBranchListBloc
    extends BlocEventStateBase<ReceiptBranchListEvent, ReceiptBranchListState> {
  ReceiptBranchListBloc()
      : super(
          initialState: ReceiptBranchListState.noAction(),
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
  Stream<ReceiptBranchListState> eventHandler(ReceiptBranchListEvent event,
      ReceiptBranchListState currentState) async* {
    switch (event.event) {
      case ReceiptBranchListEventType.activedSearch:
        {
          yield ReceiptBranchListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case ReceiptBranchListEventType.deactivedSearch:
        {
          yield ReceiptBranchListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            ReceiptBranchListResponse response =
                await _repository.receiptBranchList_FetchNextPage(0, "");
            if (response == null) {
              yield ReceiptBranchListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptBranchListState.failure(
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

                yield ReceiptBranchListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield ReceiptBranchListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case ReceiptBranchListEventType.firstPage:
        {
          yield ReceiptBranchListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptBranchListResponse response = await _repository
                .receiptBranchList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield ReceiptBranchListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptBranchListState.failure(
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
                yield ReceiptBranchListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptBranchListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReceiptBranchListEventType.nextPage:
        {
          yield ReceiptBranchListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptBranchListResponse response =
                await _repository.receiptBranchList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReceiptBranchListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptBranchListState.failure(
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
                yield ReceiptBranchListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptBranchListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReceiptBranchListEventType.refresh:
        {
          yield ReceiptBranchListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptBranchListResponse response =
                await _repository.receiptBranchList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReceiptBranchListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptBranchListState.failure(
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
                yield ReceiptBranchListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptBranchListState.failure(
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
