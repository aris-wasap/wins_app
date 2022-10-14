import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_receipt/list_wo/goods_receipt_wo_list_event.dart';
import 'package:wins_app/blocs/goods_receipt/list_wo/goods_receipt_wo_list_state.dart';
import 'package:wins_app/models/goods_receipt_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GoodsReceiptWOListBloc extends BlocEventStateBase<GoodsReceiptWOListEvent,
    GoodsReceiptWOListState> {
  GoodsReceiptWOListBloc()
      : super(
          initialState: GoodsReceiptWOListState.noAction(),
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
  Stream<GoodsReceiptWOListState> eventHandler(GoodsReceiptWOListEvent event,
      GoodsReceiptWOListState currentState) async* {
    switch (event.event) {
      case GoodsReceiptWOListEventType.activedSearch:
        {
          yield GoodsReceiptWOListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case GoodsReceiptWOListEventType.deactivedSearch:
        {
          yield GoodsReceiptWOListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            GoodsReceiptListResponse response = await _repository
                .goodsReceiptProductionList_FetchNextPage(0, "");
            if (response == null) {
              yield GoodsReceiptWOListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsReceiptWOListState.failure(
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

                yield GoodsReceiptWOListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield GoodsReceiptWOListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case GoodsReceiptWOListEventType.firstPage:
        {
          yield GoodsReceiptWOListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsReceiptListResponse response = await _repository
                .goodsReceiptProductionList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield GoodsReceiptWOListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsReceiptWOListState.failure(
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
                yield GoodsReceiptWOListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsReceiptWOListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsReceiptWOListEventType.nextPage:
        {
          yield GoodsReceiptWOListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsReceiptListResponse response =
                await _repository.goodsReceiptProductionList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield GoodsReceiptWOListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsReceiptWOListState.failure(
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
                yield GoodsReceiptWOListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsReceiptWOListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsReceiptWOListEventType.refresh:
        {
          yield GoodsReceiptWOListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsReceiptListResponse response =
                await _repository.goodsReceiptProductionList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield GoodsReceiptWOListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsReceiptWOListState.failure(
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
                yield GoodsReceiptWOListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsReceiptWOListState.failure(
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
