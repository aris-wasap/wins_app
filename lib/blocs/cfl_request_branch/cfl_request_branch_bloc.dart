import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/cfl_request_branch/cfl_request_branch_event.dart';
import 'package:admart_app/blocs/cfl_request_branch/cfl_request_branch_state.dart';
import 'package:admart_app/models/cfl_request_branch_response.dart'; 
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflRequestBranchBloc extends BlocEventStateBase<CflRequestBranchEvent, CflRequestBranchState> {
  CflRequestBranchBloc()
      : super(
          initialState: CflRequestBranchState.noAction(),
        ); 
 
  @override
  void dispose() { 

    super.dispose();
  }

  @override
  Stream<CflRequestBranchState> eventHandler(
      CflRequestBranchEvent event, CflRequestBranchState currentState) async* {
    switch (event.event) {
      case CflRequestBranchEventType.activedSearch:
        yield CflRequestBranchState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflRequestBranchEventType.deactivedSearch:
        {
          yield CflRequestBranchState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflRequestBranchResponse response = await _repository
                .cflRequestBranch_FetchNextPage(0,  "");
            if (response == null) {
              yield CflRequestBranchState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflRequestBranchState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else { 

                yield CflRequestBranchState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflRequestBranchState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflRequestBranchEventType.firstPage:
        { 

          yield CflRequestBranchState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflRequestBranchResponse response =
                await _repository.cflRequestBranch_FetchNextPage(
                    0,  event.searchQuery);
            if (response == null) {
              yield CflRequestBranchState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflRequestBranchState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflRequestBranchState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflRequestBranchState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflRequestBranchEventType.nextPage:
        {
          yield CflRequestBranchState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflRequestBranchResponse response =
                await _repository.cflRequestBranch_FetchNextPage(
                    currentState.data.length, 
                    event.searchQuery);
            if (response == null) {
              yield CflRequestBranchState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflRequestBranchState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                
                var data = currentState.data;
                data.addAll(response.data);
                yield CflRequestBranchState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflRequestBranchState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflRequestBranchEventType.refresh:
        {
          yield CflRequestBranchState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflRequestBranchResponse response = await _repository.cflRequestBranch_FetchNextPage(
               0, 
                event.searchQuery);
            if (response == null) {
              yield CflRequestBranchState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflRequestBranchState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflRequestBranchState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflRequestBranchState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflRequestBranchEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflRequestBranchState.success(
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
