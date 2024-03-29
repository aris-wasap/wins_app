import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_receipt/list/goods_receipt_list_event.dart';
import 'package:wins_app/blocs/goods_receipt/list/goods_receipt_list_state.dart';
import 'package:wins_app/models/goods_receipt_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GoodsReceiptListBloc
    extends BlocEventStateBase<GoodsReceiptListEvent, GoodsReceiptListState> {
  GoodsReceiptListBloc()
      : super(
          initialState: GoodsReceiptListState.noAction(),
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
  Stream<GoodsReceiptListState> eventHandler(
      GoodsReceiptListEvent event, GoodsReceiptListState currentState) async* {
    switch (event.event) {
      case GoodsReceiptListEventType.activedSearch:
        {
          yield GoodsReceiptListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case GoodsReceiptListEventType.deactivedSearch:
        {
          yield GoodsReceiptListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            GoodsReceiptListResponse response =
                await _repository.goodsReceiptList_FetchNextPage(0, "", 0);
            if (response == null) {
              yield GoodsReceiptListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsReceiptListState.failure(
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

                yield GoodsReceiptListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield GoodsReceiptListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case GoodsReceiptListEventType.firstPage:
        {
          yield GoodsReceiptListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsReceiptListResponse response = await _repository
                .goodsReceiptList_FetchNextPage(0, event.searchQuery, event.woId);
            if (response == null) {
              yield GoodsReceiptListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsReceiptListState.failure(
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
                yield GoodsReceiptListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsReceiptListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsReceiptListEventType.nextPage:
        {
          yield GoodsReceiptListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsReceiptListResponse response =
                await _repository.goodsReceiptList_FetchNextPage(
                    _lastIdController.value, event.searchQuery, event.woId);
            if (response == null) {
              yield GoodsReceiptListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsReceiptListState.failure(
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
                yield GoodsReceiptListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsReceiptListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsReceiptListEventType.refresh:
        {
          yield GoodsReceiptListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsReceiptListResponse response =
                await _repository.goodsReceiptList_Refresh(
                    _lastIdController.value, event.searchQuery, event.woId);
            if (response == null) {
              yield GoodsReceiptListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsReceiptListState.failure(
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
                yield GoodsReceiptListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsReceiptListState.failure(
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
