import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/purchase_credit/list/purchase_credit_list_event.dart';
import 'package:admart_app/blocs/purchase_credit/list/purchase_credit_list_state.dart';
import 'package:admart_app/models/purchase_credit_list_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PurchaseCreditListBloc
    extends BlocEventStateBase<PurchaseCreditListEvent, PurchaseCreditListState> {
  PurchaseCreditListBloc()
      : super(
          initialState: PurchaseCreditListState.noAction(),
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
  Stream<PurchaseCreditListState> eventHandler(PurchaseCreditListEvent event,
      PurchaseCreditListState currentState) async* {
    switch (event.event) {
      case PurchaseCreditListEventType.activedSearch:
        {
          yield PurchaseCreditListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case PurchaseCreditListEventType.deactivedSearch:
        {
          yield PurchaseCreditListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            PurchaseCreditListResponse response =
                await _repository.purchaseCreditList_FetchNextPage(0, "");
            if (response == null) {
              yield PurchaseCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield PurchaseCreditListState.failure(
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

                yield PurchaseCreditListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield PurchaseCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case PurchaseCreditListEventType.firstPage:
        {
          yield PurchaseCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PurchaseCreditListResponse response = await _repository
                .purchaseCreditList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield PurchaseCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PurchaseCreditListState.failure(
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
                yield PurchaseCreditListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PurchaseCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case PurchaseCreditListEventType.nextPage:
        {
          yield PurchaseCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PurchaseCreditListResponse response =
                await _repository.purchaseCreditList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield PurchaseCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PurchaseCreditListState.failure(
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
                yield PurchaseCreditListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PurchaseCreditListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case PurchaseCreditListEventType.refresh:
        {
          yield PurchaseCreditListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            PurchaseCreditListResponse response =
                await _repository.purchaseCreditList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield PurchaseCreditListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield PurchaseCreditListState.failure(
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
                yield PurchaseCreditListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield PurchaseCreditListState.failure(
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
