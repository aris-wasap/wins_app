import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue_mixing/list/goods_issue_mixing_list_event.dart';
import 'package:wins_app/blocs/goods_issue_mixing/list/goods_issue_mixing_list_state.dart';
import 'package:wins_app/models/goods_issue_mixing_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

// note: woId masih hardcode
class GoodsIssueMixingListBloc extends BlocEventStateBase<
    GoodsIssueMixingListEvent, GoodsIssueMixingListState> {
  GoodsIssueMixingListBloc()
      : super(
          initialState: GoodsIssueMixingListState.noAction(),
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
  Stream<GoodsIssueMixingListState> eventHandler(
      GoodsIssueMixingListEvent event,
      GoodsIssueMixingListState currentState) async* {
    switch (event.event) {
      case GoodsIssueMixingListEventType.activedSearch:
        {
          yield GoodsIssueMixingListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case GoodsIssueMixingListEventType.deactivedSearch:
        {
          yield GoodsIssueMixingListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            GoodsIssueMixingListResponse response = await _repository
                .goodsIssueMixingList_FetchNextPage(0, "", 0);
            if (response == null) {
              yield GoodsIssueMixingListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueMixingListState.failure(
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

                yield GoodsIssueMixingListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield GoodsIssueMixingListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case GoodsIssueMixingListEventType.firstPage:
        {
          yield GoodsIssueMixingListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueMixingListResponse response = await _repository
                .goodsIssueMixingList_FetchNextPage(0, event.searchQuery, event.woId);
            if (response == null) {
              yield GoodsIssueMixingListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueMixingListState.failure(
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
                yield GoodsIssueMixingListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueMixingListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsIssueMixingListEventType.nextPage:
        {
          yield GoodsIssueMixingListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueMixingListResponse response =
                await _repository.goodsIssueMixingList_FetchNextPage(
                    _lastIdController.value, event.searchQuery, event.woId);
            if (response == null) {
              yield GoodsIssueMixingListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueMixingListState.failure(
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
                yield GoodsIssueMixingListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueMixingListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsIssueMixingListEventType.refresh:
        {
          yield GoodsIssueMixingListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueMixingListResponse response =
                await _repository.goodsIssueMixingList_Refresh(
                    _lastIdController.value, event.searchQuery, event.woId);
            if (response == null) {
              yield GoodsIssueMixingListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueMixingListState.failure(
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
                yield GoodsIssueMixingListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueMixingListState.failure(
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
