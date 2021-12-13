import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/cfl_batch_location/cfl_batch_location_event.dart';
import 'package:wins_app/blocs/cfl_batch_location/cfl_batch_location_state.dart';
import 'package:wins_app/models/cfl_batch_location_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflBatchLocationBloc
    extends BlocEventStateBase<CflBatchLocationEvent, CflBatchLocationState> {
  CflBatchLocationBloc()
      : super(
          initialState: CflBatchLocationState.noAction(),
        );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<CflBatchLocationState> eventHandler(
      CflBatchLocationEvent event, CflBatchLocationState currentState) async* {
    switch (event.event) {
      case CflBatchLocationEventType.activedSearch:
        yield CflBatchLocationState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflBatchLocationEventType.deactivedSearch:
        {
          yield CflBatchLocationState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflBatchLocationResponse response = await _repository
                .cflBatchLocation_FetchNextPage(0, "", "", "", "");
            if (response == null) {
              yield CflBatchLocationState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflBatchLocationState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflBatchLocationState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflBatchLocationState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflBatchLocationEventType.firstPage:
        {
          yield CflBatchLocationState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflBatchLocationResponse response =
                await _repository.cflBatchLocation_FetchNextPage(
                    0,
                    event.searchQuery,
                    event.whsCode,
                    event.batchNo,
                    event.itemCode);
            if (response == null) {
              yield CflBatchLocationState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflBatchLocationState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflBatchLocationState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflBatchLocationState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflBatchLocationEventType.nextPage:
        {
          yield CflBatchLocationState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflBatchLocationResponse response =
                await _repository.cflBatchLocation_FetchNextPage(
                    currentState.data.length,
                    event.searchQuery,
                    event.whsCode,
                    event.batchNo,
                    event.itemCode);
            if (response == null) {
              yield CflBatchLocationState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflBatchLocationState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                var data = currentState.data;
                data.addAll(response.data);
                yield CflBatchLocationState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflBatchLocationState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflBatchLocationEventType.refresh:
        {
          yield CflBatchLocationState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflBatchLocationResponse response =
                await _repository.cflBatchLocation_FetchNextPage(
                    0,
                    event.searchQuery,
                    event.whsCode,
                    event.batchNo,
                    event.itemCode);
            if (response == null) {
              yield CflBatchLocationState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflBatchLocationState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflBatchLocationState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflBatchLocationState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflBatchLocationEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflBatchLocationState.success(
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
