import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/cfl_return_request_delivery/cfl_return_request_delivery_event.dart';
import 'package:wins_app/blocs/cfl_return_request_delivery/cfl_return_request_delivery_state.dart';
import 'package:wins_app/models/cfl_return_request_delivery_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:rxdart/rxdart.dart';

class CflReturnRequestDeliveryBloc extends BlocEventStateBase<
    CflReturnRequestDeliveryEvent, CflReturnRequestDeliveryState> {
  CflReturnRequestDeliveryBloc()
      : super(
          initialState: CflReturnRequestDeliveryState.noAction(),
        );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<CflReturnRequestDeliveryState> eventHandler(
      CflReturnRequestDeliveryEvent event,
      CflReturnRequestDeliveryState currentState) async* {
    switch (event.event) {
      case CflReturnRequestDeliveryEventType.activedSearch:
        yield CflReturnRequestDeliveryState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflReturnRequestDeliveryEventType.deactivedSearch:
        {
          yield CflReturnRequestDeliveryState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflReturnRequestDeliveryResponse response =
                await _repository.cflReturnRequestDelivery_FetchNextPage(0, "");
            if (response == null) {
              yield CflReturnRequestDeliveryState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflReturnRequestDeliveryState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflReturnRequestDeliveryState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflReturnRequestDeliveryState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflReturnRequestDeliveryEventType.firstPage:
        {
          yield CflReturnRequestDeliveryState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflReturnRequestDeliveryResponse response = await _repository
                .cflReturnRequestDelivery_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield CflReturnRequestDeliveryState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflReturnRequestDeliveryState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflReturnRequestDeliveryState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflReturnRequestDeliveryState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflReturnRequestDeliveryEventType.nextPage:
        {
          yield CflReturnRequestDeliveryState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflReturnRequestDeliveryResponse response =
                await _repository.cflReturnRequestDelivery_FetchNextPage(
                    currentState.data.length, event.searchQuery);
            if (response == null) {
              yield CflReturnRequestDeliveryState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflReturnRequestDeliveryState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                var data = currentState.data;
                data.addAll(response.data);
                yield CflReturnRequestDeliveryState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflReturnRequestDeliveryState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflReturnRequestDeliveryEventType.refresh:
        {
          yield CflReturnRequestDeliveryState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflReturnRequestDeliveryResponse response = await _repository
                .cflReturnRequestDelivery_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield CflReturnRequestDeliveryState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflReturnRequestDeliveryState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflReturnRequestDeliveryState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflReturnRequestDeliveryState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflReturnRequestDeliveryEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflReturnRequestDeliveryState.success(
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
