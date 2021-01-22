import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/cfl_payable_return_request/cfl_payable_return_request_event.dart';
import 'package:admart_app/blocs/cfl_payable_return_request/cfl_payable_return_request_state.dart';
import 'package:admart_app/models/cfl_payable_return_request_response.dart'; 
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflPayableReturnRequestBloc extends BlocEventStateBase<CflPayableReturnRequestEvent, CflPayableReturnRequestState> {
  CflPayableReturnRequestBloc()
      : super(
          initialState: CflPayableReturnRequestState.noAction(),
        ); 
 
  @override
  void dispose() { 

    super.dispose();
  }

  @override
  Stream<CflPayableReturnRequestState> eventHandler(
      CflPayableReturnRequestEvent event, CflPayableReturnRequestState currentState) async* {
    switch (event.event) {
      case CflPayableReturnRequestEventType.activedSearch:
        yield CflPayableReturnRequestState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflPayableReturnRequestEventType.deactivedSearch:
        {
          yield CflPayableReturnRequestState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPayableReturnRequestResponse response = await _repository
                .cflPayableReturnRequest_FetchNextPage(0,  "");
            if (response == null) {
              yield CflPayableReturnRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPayableReturnRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else { 

                yield CflPayableReturnRequestState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPayableReturnRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPayableReturnRequestEventType.firstPage:
        { 

          yield CflPayableReturnRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPayableReturnRequestResponse response =
                await _repository.cflPayableReturnRequest_FetchNextPage(
                    0,  event.searchQuery);
            if (response == null) {
              yield CflPayableReturnRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPayableReturnRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflPayableReturnRequestState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPayableReturnRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPayableReturnRequestEventType.nextPage:
        {
          yield CflPayableReturnRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPayableReturnRequestResponse response =
                await _repository.cflPayableReturnRequest_FetchNextPage(
                    currentState.data.length, 
                    event.searchQuery);
            if (response == null) {
              yield CflPayableReturnRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPayableReturnRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                
                var data = currentState.data;
                data.addAll(response.data);
                yield CflPayableReturnRequestState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPayableReturnRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPayableReturnRequestEventType.refresh:
        {
          yield CflPayableReturnRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPayableReturnRequestResponse response = await _repository.cflPayableReturnRequest_FetchNextPage(
               0, 
                event.searchQuery);
            if (response == null) {
              yield CflPayableReturnRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPayableReturnRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflPayableReturnRequestState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPayableReturnRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPayableReturnRequestEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflPayableReturnRequestState.success(
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
