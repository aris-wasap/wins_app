import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/cfl_binlocation/cfl_binlocation_event.dart';
import 'package:admart_app/blocs/cfl_binlocation/cfl_binlocation_state.dart';
import 'package:admart_app/models/cfl_binlocation_response.dart'; 
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflBinLocationBloc extends BlocEventStateBase<CflBinLocationEvent, CflBinLocationState> {
  CflBinLocationBloc()
      : super(
          initialState: CflBinLocationState.noAction(),
        ); 
 
  @override
  void dispose() { 

    super.dispose();
  }

  @override
  Stream<CflBinLocationState> eventHandler(
      CflBinLocationEvent event, CflBinLocationState currentState) async* {
    switch (event.event) {
      case CflBinLocationEventType.activedSearch:
        yield CflBinLocationState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflBinLocationEventType.deactivedSearch:
        {
          yield CflBinLocationState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflBinLocationResponse response = await _repository
                .cflBinLocation_FetchNextPage(0,  "","");
            if (response == null) {
              yield CflBinLocationState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflBinLocationState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else { 

                yield CflBinLocationState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflBinLocationState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflBinLocationEventType.firstPage:
        { 

          yield CflBinLocationState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflBinLocationResponse response =
                await _repository.cflBinLocation_FetchNextPage(
                    0,  event.searchQuery, event.whsCode);
            if (response == null) {
              yield CflBinLocationState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflBinLocationState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflBinLocationState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflBinLocationState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflBinLocationEventType.nextPage:
        {
          yield CflBinLocationState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflBinLocationResponse response =
                await _repository.cflBinLocation_FetchNextPage(
                    currentState.data.length, 
                    event.searchQuery, event.whsCode);
            if (response == null) {
              yield CflBinLocationState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflBinLocationState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                
                var data = currentState.data;
                data.addAll(response.data);
                yield CflBinLocationState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflBinLocationState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflBinLocationEventType.refresh:
        {
          yield CflBinLocationState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflBinLocationResponse response = await _repository.cflBinLocation_FetchNextPage(
               0, 
                event.searchQuery, event.whsCode);
            if (response == null) {
              yield CflBinLocationState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflBinLocationState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflBinLocationState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflBinLocationState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflBinLocationEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflBinLocationState.success(
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
