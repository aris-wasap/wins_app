import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/cfl_purchase_delivery/cfl_purchase_delivery_event.dart';
import 'package:wins_app/blocs/cfl_purchase_delivery/cfl_purchase_delivery_state.dart';
import 'package:wins_app/models/cfl_purchase_delivery_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:rxdart/rxdart.dart';

class CflPurchaseDeliveryBloc extends BlocEventStateBase<
    CflPurchaseDeliveryEvent, CflPurchaseDeliveryState> {
  CflPurchaseDeliveryBloc()
      : super(
          initialState: CflPurchaseDeliveryState.noAction(),
        );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<CflPurchaseDeliveryState> eventHandler(CflPurchaseDeliveryEvent event,
      CflPurchaseDeliveryState currentState) async* {
    switch (event.event) {
      case CflPurchaseDeliveryEventType.activedSearch:
        yield CflPurchaseDeliveryState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflPurchaseDeliveryEventType.deactivedSearch:
        {
          yield CflPurchaseDeliveryState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPurchaseDeliveryResponse response =
                await _repository.cflPurchaseDelivery_FetchNextPage(0, "");
            if (response == null) {
              yield CflPurchaseDeliveryState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPurchaseDeliveryState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflPurchaseDeliveryState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPurchaseDeliveryState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPurchaseDeliveryEventType.firstPage:
        {
          yield CflPurchaseDeliveryState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPurchaseDeliveryResponse response = await _repository
                .cflPurchaseDelivery_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield CflPurchaseDeliveryState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPurchaseDeliveryState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflPurchaseDeliveryState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPurchaseDeliveryState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPurchaseDeliveryEventType.nextPage:
        {
          yield CflPurchaseDeliveryState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPurchaseDeliveryResponse response =
                await _repository.cflPurchaseDelivery_FetchNextPage(
                    currentState.data.length, event.searchQuery);
            if (response == null) {
              yield CflPurchaseDeliveryState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPurchaseDeliveryState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                var data = currentState.data;
                data.addAll(response.data);
                yield CflPurchaseDeliveryState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPurchaseDeliveryState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPurchaseDeliveryEventType.refresh:
        {
          yield CflPurchaseDeliveryState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPurchaseDeliveryResponse response = await _repository
                .cflPurchaseDelivery_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield CflPurchaseDeliveryState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPurchaseDeliveryState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflPurchaseDeliveryState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPurchaseDeliveryState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPurchaseDeliveryEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflPurchaseDeliveryState.success(
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
