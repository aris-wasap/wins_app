import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue_mixing/list_wo/goods_issue_mixing_wo_list_event.dart';
import 'package:wins_app/blocs/goods_issue_mixing/list_wo/goods_issue_mixing_wo_list_state.dart';
import 'package:wins_app/models/goods_issue_mixing_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GoodsIssueMixingWOListBloc extends BlocEventStateBase<
    GoodsIssueMixingWOListEvent, GoodsIssueMixingWOListState> {
  GoodsIssueMixingWOListBloc()
      : super(
          initialState: GoodsIssueMixingWOListState.noAction(),
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
  Stream<GoodsIssueMixingWOListState> eventHandler(
      GoodsIssueMixingWOListEvent event,
      GoodsIssueMixingWOListState currentState) async* {
    switch (event.event) {
      case GoodsIssueMixingWOListEventType.activedSearch:
        {
          yield GoodsIssueMixingWOListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case GoodsIssueMixingWOListEventType.deactivedSearch:
        {
          yield GoodsIssueMixingWOListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            GoodsIssueMixingListResponse response = await _repository
                .goodsIssueMixingProductionList_FetchNextPage(0, "");
            if (response == null) {
              yield GoodsIssueMixingWOListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueMixingWOListState.failure(
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

                yield GoodsIssueMixingWOListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield GoodsIssueMixingWOListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case GoodsIssueMixingWOListEventType.firstPage:
        {
          yield GoodsIssueMixingWOListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueMixingListResponse response =
                await _repository.goodsIssueMixingProductionList_FetchNextPage(
                    0, event.searchQuery);
            if (response == null) {
              yield GoodsIssueMixingWOListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueMixingWOListState.failure(
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
                yield GoodsIssueMixingWOListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueMixingWOListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsIssueMixingWOListEventType.nextPage:
        {
          yield GoodsIssueMixingWOListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueMixingListResponse response =
                await _repository.goodsIssueMixingProductionList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield GoodsIssueMixingWOListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueMixingWOListState.failure(
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
                yield GoodsIssueMixingWOListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueMixingWOListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsIssueMixingWOListEventType.refresh:
        {
          yield GoodsIssueMixingWOListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueMixingListResponse response =
                await _repository.goodsIssueMixingList_Refresh(
                    _lastIdController.value, event.searchQuery, event.woId);
            if (response == null) {
              yield GoodsIssueMixingWOListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueMixingWOListState.failure(
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
                yield GoodsIssueMixingWOListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueMixingWOListState.failure(
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
