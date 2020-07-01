import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/issue_production/list/issue_production_list_event.dart';
import 'package:admart_app/blocs/issue_production/list/issue_production_list_state.dart';
import 'package:admart_app/models/issue_production_list_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class IssueProductionListBloc
    extends BlocEventStateBase<IssueProductionListEvent, IssueProductionListState> {
  IssueProductionListBloc()
      : super(
          initialState: IssueProductionListState.noAction(),
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
  Stream<IssueProductionListState> eventHandler(IssueProductionListEvent event,
      IssueProductionListState currentState) async* {
    switch (event.event) {
      case IssueProductionListEventType.activedSearch:
        {
          yield IssueProductionListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case IssueProductionListEventType.deactivedSearch:
        {
          yield IssueProductionListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            IssueProductionListResponse response =
                await _repository.issueProductionList_FetchNextPage(0, "");
            if (response == null) {
              yield IssueProductionListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield IssueProductionListState.failure(
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

                yield IssueProductionListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield IssueProductionListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case IssueProductionListEventType.firstPage:
        {
          yield IssueProductionListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            IssueProductionListResponse response = await _repository
                .issueProductionList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield IssueProductionListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield IssueProductionListState.failure(
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
                yield IssueProductionListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield IssueProductionListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case IssueProductionListEventType.nextPage:
        {
          yield IssueProductionListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            IssueProductionListResponse response =
                await _repository.issueProductionList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield IssueProductionListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield IssueProductionListState.failure(
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
                yield IssueProductionListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield IssueProductionListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case IssueProductionListEventType.refresh:
        {
          yield IssueProductionListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            IssueProductionListResponse response =
                await _repository.issueProductionList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield IssueProductionListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield IssueProductionListState.failure(
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
                yield IssueProductionListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield IssueProductionListState.failure(
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
