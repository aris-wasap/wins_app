import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/cfl_production_order/cfl_production_order_event.dart';
import 'package:ncf_app/blocs/cfl_production_order/cfl_production_order_state.dart';
import 'package:ncf_app/models/cfl_production_order_response.dart'; 
import 'package:ncf_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflProductionOrderBloc extends BlocEventStateBase<CflProductionOrderEvent, CflProductionOrderState> {
  CflProductionOrderBloc()
      : super(
          initialState: CflProductionOrderState.noAction(),
        ); 
 
  @override
  void dispose() { 

    super.dispose();
  }

  @override
  Stream<CflProductionOrderState> eventHandler(
      CflProductionOrderEvent event, CflProductionOrderState currentState) async* {
    switch (event.event) {
      case CflProductionOrderEventType.activedSearch:
        yield CflProductionOrderState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflProductionOrderEventType.deactivedSearch:
        {
          yield CflProductionOrderState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflProductionOrderResponse response = await _repository
                .cflProductionOrder_FetchNextPage(0,  "");
            if (response == null) {
              yield CflProductionOrderState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflProductionOrderState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else { 

                yield CflProductionOrderState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflProductionOrderState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflProductionOrderEventType.firstPage:
        { 

          yield CflProductionOrderState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflProductionOrderResponse response =
                await _repository.cflProductionOrder_FetchNextPage(
                    0,  event.searchQuery);
            if (response == null) {
              yield CflProductionOrderState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflProductionOrderState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflProductionOrderState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflProductionOrderState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflProductionOrderEventType.nextPage:
        {
          yield CflProductionOrderState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflProductionOrderResponse response =
                await _repository.cflProductionOrder_FetchNextPage(
                    currentState.data.length, 
                    event.searchQuery);
            if (response == null) {
              yield CflProductionOrderState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflProductionOrderState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                
                var data = currentState.data;
                data.addAll(response.data);
                yield CflProductionOrderState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflProductionOrderState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflProductionOrderEventType.refresh:
        {
          yield CflProductionOrderState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflProductionOrderResponse response = await _repository.cflProductionOrder_FetchNextPage(
               0, 
                event.searchQuery);
            if (response == null) {
              yield CflProductionOrderState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflProductionOrderState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflProductionOrderState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflProductionOrderState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflProductionOrderEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflProductionOrderState.success(
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
