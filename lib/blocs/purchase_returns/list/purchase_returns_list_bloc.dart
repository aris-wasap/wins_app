import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/purchase_returns/list/purchase_returns_list_event.dart';
import 'package:wins_app/blocs/purchase_returns/list/purchase_returns_list_state.dart';
import 'package:wins_app/models/purchase_returns_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PurchaseReturnsListBloc extends BlocEventStateBase<
    PurchaseReturnsListEvent, PurchaseReturnsListState> {
  PurchaseReturnsListBloc()
      : super(
          initialState: PurchaseReturnsListState.noAction(),
        );

  final BehaviorSubject<int> _firstIdController =
      BehaviorSubject<int>(seedValue: 0);
  final BehaviorSubject<int> _lastIdController =
      BehaviorSubject<int>(seedValue: 0);

  @override
  void dispose() {
    _firstIdController.close();
    _lastIdController.close();

    super.dispose();
  }

  @override
  Stream<PurchaseReturnsListState> eventHandler(PurchaseReturnsListEvent event,
      PurchaseReturnsListState currentState) async* {
    switch (event.event) {
      case PurchaseReturnsListEventType.activedSearch:
        {
          yield PurchaseReturnsListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case PurchaseReturnsListEventType.deactivedSearch:
        {
          yield PurchaseReturnsListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            PurchaseReturnsListResponse response =
                await _repository.purchaseReturnsList_FetchNextPage(0, "");
            if (response == null) {
              yield PurchaseReturnsListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield PurchaseReturnsListState.failure(
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

                yield PurchaseReturnsListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield PurchaseReturnsListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case PurchaseReturnsListEventType.firstPage:
        {
          yield PurchaseReturnsListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PurchaseReturnsListResponse response = await _repository
                .purchaseReturnsList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield PurchaseReturnsListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PurchaseReturnsListState.failure(
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
                yield PurchaseReturnsListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PurchaseReturnsListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case PurchaseReturnsListEventType.nextPage:
        {
          yield PurchaseReturnsListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PurchaseReturnsListResponse response =
                await _repository.purchaseReturnsList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield PurchaseReturnsListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PurchaseReturnsListState.failure(
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
                yield PurchaseReturnsListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PurchaseReturnsListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case PurchaseReturnsListEventType.refresh:
        {
          yield PurchaseReturnsListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PurchaseReturnsListResponse response =
                await _repository.purchaseReturnsList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield PurchaseReturnsListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PurchaseReturnsListState.failure(
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
                yield PurchaseReturnsListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PurchaseReturnsListState.failure(
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
