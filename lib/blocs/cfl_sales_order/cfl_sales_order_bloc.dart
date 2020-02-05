import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/cfl_sales_order/cfl_sales_order_event.dart';
import 'package:ncf_app/blocs/cfl_sales_order/cfl_sales_order_state.dart';
import 'package:ncf_app/models/cfl_sales_order_response.dart'; 
import 'package:ncf_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflSalesOrderBloc extends BlocEventStateBase<CflSalesOrderEvent, CflSalesOrderState> {
  CflSalesOrderBloc()
      : super(
          initialState: CflSalesOrderState.noAction(),
        ); 
 
  @override
  void dispose() { 

    super.dispose();
  }

  @override
  Stream<CflSalesOrderState> eventHandler(
      CflSalesOrderEvent event, CflSalesOrderState currentState) async* {
    switch (event.event) {
      case CflSalesOrderEventType.activedSearch:
        yield CflSalesOrderState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflSalesOrderEventType.deactivedSearch:
        {
          yield CflSalesOrderState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflSalesOrderResponse response = await _repository
                .cflSalesOrder_FetchNextPage(0,  "");
            if (response == null) {
              yield CflSalesOrderState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflSalesOrderState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else { 

                yield CflSalesOrderState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflSalesOrderState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflSalesOrderEventType.firstPage:
        { 

          yield CflSalesOrderState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflSalesOrderResponse response =
                await _repository.cflSalesOrder_FetchNextPage(
                    0,  event.searchQuery);
            if (response == null) {
              yield CflSalesOrderState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflSalesOrderState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflSalesOrderState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflSalesOrderState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflSalesOrderEventType.nextPage:
        {
          yield CflSalesOrderState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflSalesOrderResponse response =
                await _repository.cflSalesOrder_FetchNextPage(
                    currentState.data.length, 
                    event.searchQuery);
            if (response == null) {
              yield CflSalesOrderState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflSalesOrderState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                
                var data = currentState.data;
                data.addAll(response.data);
                yield CflSalesOrderState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflSalesOrderState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflSalesOrderEventType.refresh:
        {
          yield CflSalesOrderState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflSalesOrderResponse response = await _repository.cflSalesOrder_FetchNextPage(
               0, 
                event.searchQuery);
            if (response == null) {
              yield CflSalesOrderState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflSalesOrderState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflSalesOrderState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflSalesOrderState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflSalesOrderEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflSalesOrderState.success(
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
