import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/cfl_item_batch/cfl_item_batch_event.dart';
import 'package:wins_app/blocs/cfl_item_batch/cfl_item_batch_state.dart';
import 'package:wins_app/models/cfl_item_batch_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:rxdart/rxdart.dart';

class CflItemBatchBloc
    extends BlocEventStateBase<CflItemBatchEvent, CflItemBatchState> {
  CflItemBatchBloc()
      : super(
          initialState: CflItemBatchState.noAction(),
        );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<CflItemBatchState> eventHandler(
      CflItemBatchEvent event, CflItemBatchState currentState) async* {
    switch (event.event) {
      case CflItemBatchEventType.activedSearch:
        yield CflItemBatchState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflItemBatchEventType.deactivedSearch:
        {
          yield CflItemBatchState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflItemBatchResponse response =
                await _repository.cflItemBatch_FetchNextPage(0, "", "", "", 0);
            if (response == null) {
              yield CflItemBatchState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflItemBatchState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflItemBatchState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflItemBatchState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflItemBatchEventType.firstPage:
        {
          yield CflItemBatchState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflItemBatchResponse response =
                await _repository.cflItemBatch_FetchNextPage(0,
                    event.searchQuery, event.whsCode, event.batchNo, event.id);
            if (response == null) {
              yield CflItemBatchState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflItemBatchState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflItemBatchState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflItemBatchState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflItemBatchEventType.nextPage:
        {
          yield CflItemBatchState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflItemBatchResponse response =
                await _repository.cflItemBatch_FetchNextPage(
                    currentState.data.length,
                    event.searchQuery,
                    event.whsCode,
                    event.batchNo,
                    event.id);
            if (response == null) {
              yield CflItemBatchState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflItemBatchState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                var data = currentState.data;
                data.addAll(response.data);
                yield CflItemBatchState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflItemBatchState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflItemBatchEventType.refresh:
        {
          yield CflItemBatchState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflItemBatchResponse response =
                await _repository.cflItemBatch_FetchNextPage(0,
                    event.searchQuery, event.whsCode, event.batchNo, event.id);
            if (response == null) {
              yield CflItemBatchState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflItemBatchState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflItemBatchState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflItemBatchState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflItemBatchEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflItemBatchState.success(
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
