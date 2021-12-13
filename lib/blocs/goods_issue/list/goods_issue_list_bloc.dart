import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue/list/goods_issue_list_event.dart';
import 'package:wins_app/blocs/goods_issue/list/goods_issue_list_state.dart';
import 'package:wins_app/models/goods_issue_list_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GoodsIssueListBloc
    extends BlocEventStateBase<GoodsIssueListEvent, GoodsIssueListState> {
  GoodsIssueListBloc()
      : super(
          initialState: GoodsIssueListState.noAction(),
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
  Stream<GoodsIssueListState> eventHandler(
      GoodsIssueListEvent event, GoodsIssueListState currentState) async* {
    switch (event.event) {
      case GoodsIssueListEventType.activedSearch:
        {
          yield GoodsIssueListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case GoodsIssueListEventType.deactivedSearch:
        {
          yield GoodsIssueListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            GoodsIssueListResponse response =
                await _repository.goodsIssueList_FetchNextPage(0, "");
            if (response == null) {
              yield GoodsIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueListState.failure(
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

                yield GoodsIssueListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield GoodsIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case GoodsIssueListEventType.firstPage:
        {
          yield GoodsIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueListResponse response = await _repository
                .goodsIssueList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield GoodsIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueListState.failure(
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
                yield GoodsIssueListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsIssueListEventType.nextPage:
        {
          yield GoodsIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueListResponse response =
                await _repository.goodsIssueList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield GoodsIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueListState.failure(
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
                yield GoodsIssueListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case GoodsIssueListEventType.refresh:
        {
          yield GoodsIssueListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            GoodsIssueListResponse response =
                await _repository.goodsIssueList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield GoodsIssueListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield GoodsIssueListState.failure(
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
                yield GoodsIssueListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield GoodsIssueListState.failure(
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
