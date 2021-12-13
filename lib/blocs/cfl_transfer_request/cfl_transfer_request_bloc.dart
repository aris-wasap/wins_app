import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/cfl_transfer_request/cfl_transfer_request_event.dart';
import 'package:wins_app/blocs/cfl_transfer_request/cfl_transfer_request_state.dart';
import 'package:wins_app/models/cfl_transfer_request_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflTransferRequestBloc extends BlocEventStateBase<CflTransferRequestEvent,
    CflTransferRequestState> {
  CflTransferRequestBloc()
      : super(
          initialState: CflTransferRequestState.noAction(),
        );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<CflTransferRequestState> eventHandler(CflTransferRequestEvent event,
      CflTransferRequestState currentState) async* {
    switch (event.event) {
      case CflTransferRequestEventType.activedSearch:
        yield CflTransferRequestState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflTransferRequestEventType.deactivedSearch:
        {
          yield CflTransferRequestState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflTransferRequestResponse response =
                await _repository.cflTransferRequest_FetchNextPage(0, "", "");
            if (response == null) {
              yield CflTransferRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflTransferRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflTransferRequestState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflTransferRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflTransferRequestEventType.firstPage:
        {
          yield CflTransferRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflTransferRequestResponse response =
                await _repository.cflTransferRequest_FetchNextPage(
                    0, event.searchQuery, event.transType);
            if (response == null) {
              yield CflTransferRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflTransferRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflTransferRequestState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflTransferRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflTransferRequestEventType.nextPage:
        {
          yield CflTransferRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflTransferRequestResponse response =
                await _repository.cflTransferRequest_FetchNextPage(
                    currentState.data.length,
                    event.searchQuery,
                    event.transType);
            if (response == null) {
              yield CflTransferRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflTransferRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                var data = currentState.data;
                data.addAll(response.data);
                yield CflTransferRequestState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflTransferRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflTransferRequestEventType.refresh:
        {
          yield CflTransferRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflTransferRequestResponse response =
                await _repository.cflTransferRequest_FetchNextPage(
                    0, event.searchQuery, event.transType);
            if (response == null) {
              yield CflTransferRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflTransferRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflTransferRequestState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflTransferRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflTransferRequestEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflTransferRequestState.success(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
        }

        break;
      default:
        {}
    }
  }
}
