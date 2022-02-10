import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/cfl_receipt_production/cfl_receipt_production_event.dart';
import 'package:wins_app/blocs/cfl_receipt_production/cfl_receipt_production_state.dart';
import 'package:wins_app/models/cfl_receipt_production_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:rxdart/rxdart.dart';

class CflReceiptProductionBloc extends BlocEventStateBase<
    CflReceiptProductionEvent, CflReceiptProductionState> {
  CflReceiptProductionBloc()
      : super(
          initialState: CflReceiptProductionState.noAction(),
        );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<CflReceiptProductionState> eventHandler(
      CflReceiptProductionEvent event,
      CflReceiptProductionState currentState) async* {
    switch (event.event) {
      case CflReceiptProductionEventType.activedSearch:
        yield CflReceiptProductionState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflReceiptProductionEventType.deactivedSearch:
        {
          yield CflReceiptProductionState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflReceiptProductionResponse response =
                await _repository.cflReceiptProduction_FetchNextPage(0, "");
            if (response == null) {
              yield CflReceiptProductionState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflReceiptProductionState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflReceiptProductionState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflReceiptProductionState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflReceiptProductionEventType.firstPage:
        {
          yield CflReceiptProductionState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflReceiptProductionResponse response = await _repository
                .cflReceiptProduction_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield CflReceiptProductionState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflReceiptProductionState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflReceiptProductionState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflReceiptProductionState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflReceiptProductionEventType.nextPage:
        {
          yield CflReceiptProductionState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflReceiptProductionResponse response =
                await _repository.cflReceiptProduction_FetchNextPage(
                    currentState.data.length, event.searchQuery);
            if (response == null) {
              yield CflReceiptProductionState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflReceiptProductionState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                var data = currentState.data;
                data.addAll(response.data);
                yield CflReceiptProductionState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflReceiptProductionState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflReceiptProductionEventType.refresh:
        {
          yield CflReceiptProductionState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflReceiptProductionResponse response = await _repository
                .cflReceiptProduction_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield CflReceiptProductionState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflReceiptProductionState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflReceiptProductionState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflReceiptProductionState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflReceiptProductionEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflReceiptProductionState.success(
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
