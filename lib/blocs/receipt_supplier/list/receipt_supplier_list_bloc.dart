import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/receipt_supplier/list/receipt_supplier_list_event.dart';
import 'package:ncf_app/blocs/receipt_supplier/list/receipt_supplier_list_state.dart';
import 'package:ncf_app/models/receipt_supplier_list_response.dart';
import 'package:ncf_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ReceiptSupplierListBloc
    extends BlocEventStateBase<ReceiptSupplierListEvent, ReceiptSupplierListState> {
  ReceiptSupplierListBloc()
      : super(
          initialState: ReceiptSupplierListState.noAction(),
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
  Stream<ReceiptSupplierListState> eventHandler(ReceiptSupplierListEvent event,
      ReceiptSupplierListState currentState) async* {
    switch (event.event) {
      case ReceiptSupplierListEventType.activedSearch:
        {
          yield ReceiptSupplierListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case ReceiptSupplierListEventType.deactivedSearch:
        {
          yield ReceiptSupplierListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            ReceiptSupplierListResponse response =
                await _repository.receiptSupplierList_FetchNextPage(0, "");
            if (response == null) {
              yield ReceiptSupplierListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptSupplierListState.failure(
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

                yield ReceiptSupplierListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield ReceiptSupplierListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case ReceiptSupplierListEventType.firstPage:
        {
          yield ReceiptSupplierListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptSupplierListResponse response = await _repository
                .receiptSupplierList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield ReceiptSupplierListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptSupplierListState.failure(
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
                yield ReceiptSupplierListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptSupplierListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReceiptSupplierListEventType.nextPage:
        {
          yield ReceiptSupplierListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptSupplierListResponse response =
                await _repository.receiptSupplierList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReceiptSupplierListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptSupplierListState.failure(
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
                yield ReceiptSupplierListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptSupplierListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case ReceiptSupplierListEventType.refresh:
        {
          yield ReceiptSupplierListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            ReceiptSupplierListResponse response =
                await _repository.receiptSupplierList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield ReceiptSupplierListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield ReceiptSupplierListState.failure(
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
                yield ReceiptSupplierListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield ReceiptSupplierListState.failure(
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
