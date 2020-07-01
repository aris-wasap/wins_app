import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/inventory_transfer/list/inventory_transfer_list_event.dart';
import 'package:admart_app/blocs/inventory_transfer/list/inventory_transfer_list_state.dart';
import 'package:admart_app/models/inventory_transfer_list_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class InventoryTransferListBloc
    extends BlocEventStateBase<InventoryTransferListEvent, InventoryTransferListState> {
  InventoryTransferListBloc()
      : super(
          initialState: InventoryTransferListState.noAction(),
        );

  final BehaviorSubject<int> _firstIdController =
      BehaviorSubject<int>(seedValue: 0);
  final BehaviorSubject<int> _lastIdController = BehaviorSubject<int>(seedValue: 0);

  @override
  void dispose() {
    _firstIdController.close();
    _lastIdController.close();

    super.dispose();
  }

  @override
  Stream<InventoryTransferListState> eventHandler(InventoryTransferListEvent event,
      InventoryTransferListState currentState) async* {
    switch (event.event) {
      case InventoryTransferListEventType.activedSearch:
        {
          yield InventoryTransferListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case InventoryTransferListEventType.deactivedSearch:
        {
          yield InventoryTransferListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            InventoryTransferListResponse response =
                await _repository.inventoryTransferList_FetchNextPage(0, "");
            if (response == null) {
              yield InventoryTransferListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield InventoryTransferListState.failure(
                    errorMessage: 'Fetch fail ${response.errorMessage}',
                    data: currentState.data,
                    isActiveSearch: false);
              } else {
                if (response.data.length == 0) {
                  _firstIdController.value = 0;
                  _lastIdController.value = 0;
                } else {
                  _firstIdController.value = response.data[0].id;
                  _lastIdController.value =
                      response.data[response.data.length - 1].id;
                }

                yield InventoryTransferListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield InventoryTransferListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case InventoryTransferListEventType.firstPage:
        {
          yield InventoryTransferListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            InventoryTransferListResponse response = await _repository
                .inventoryTransferList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield InventoryTransferListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield InventoryTransferListState.failure(
                    errorMessage: 'Fetch fail ${response.errorMessage}',
                    data: currentState.data,
                    isActiveSearch: currentState.isActiveSearch);
              } else {
                if (response.data.length == 0) {
                  _firstIdController.value = 0;
                  _lastIdController.value = 0;
                } else {
                  _firstIdController.value = response.data[0].id;
                  _lastIdController.value =
                      response.data[response.data.length - 1].id;
                }
                yield InventoryTransferListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield InventoryTransferListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case InventoryTransferListEventType.nextPage:
        {
          yield InventoryTransferListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            InventoryTransferListResponse response =
                await _repository.inventoryTransferList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield InventoryTransferListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield InventoryTransferListState.failure(
                    errorMessage: 'Fetch fail ${response.errorMessage}',
                    data: currentState.data,
                    isActiveSearch: currentState.isActiveSearch);
              } else {
                if (response.data.length == 0) {
                } else {
                  _lastIdController.value =
                      response.data[response.data.length - 1].id;
                }

                var data = currentState.data;
                data.addAll(response.data);
                yield InventoryTransferListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield InventoryTransferListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case InventoryTransferListEventType.refresh:
        {
          yield InventoryTransferListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            InventoryTransferListResponse response =
                await _repository.inventoryTransferList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield InventoryTransferListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield InventoryTransferListState.failure(
                    errorMessage: 'Fetch fail ${response.errorMessage}',
                    data: currentState.data,
                    isActiveSearch: currentState.isActiveSearch);
              } else {
                if (response.data.length == 0) {
                  _firstIdController.value = 0;
                  _lastIdController.value = 0;
                } else {
                  _firstIdController.value = response.data[0].id;
                  _lastIdController.value =
                      response.data[response.data.length - 1].id;
                }
                yield InventoryTransferListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield InventoryTransferListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      default:
        {}
    }
  }
}
