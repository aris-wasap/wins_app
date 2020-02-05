import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/transfer_release/list/transfer_release_list_event.dart';
import 'package:ncf_app/blocs/transfer_release/list/transfer_release_list_state.dart';
import 'package:ncf_app/models/transfer_release_list_response.dart';
import 'package:ncf_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TransferReleaseListBloc
    extends BlocEventStateBase<TransferReleaseListEvent, TransferReleaseListState> {
  TransferReleaseListBloc()
      : super(
          initialState: TransferReleaseListState.noAction(),
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
  Stream<TransferReleaseListState> eventHandler(TransferReleaseListEvent event,
      TransferReleaseListState currentState) async* {
    switch (event.event) {
      case TransferReleaseListEventType.activedSearch:
        {
          yield TransferReleaseListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case TransferReleaseListEventType.deactivedSearch:
        {
          yield TransferReleaseListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            TransferReleaseListResponse response =
                await _repository.transferReleaseList_FetchNextPage(0, "");
            if (response == null) {
              yield TransferReleaseListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferReleaseListState.failure(
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

                yield TransferReleaseListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield TransferReleaseListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case TransferReleaseListEventType.firstPage:
        {
          yield TransferReleaseListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferReleaseListResponse response = await _repository
                .transferReleaseList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield TransferReleaseListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferReleaseListState.failure(
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
                yield TransferReleaseListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferReleaseListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferReleaseListEventType.nextPage:
        {
          yield TransferReleaseListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferReleaseListResponse response =
                await _repository.transferReleaseList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferReleaseListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferReleaseListState.failure(
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
                yield TransferReleaseListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferReleaseListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferReleaseListEventType.refresh:
        {
          yield TransferReleaseListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferReleaseListResponse response =
                await _repository.transferReleaseList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferReleaseListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferReleaseListState.failure(
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
                yield TransferReleaseListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferReleaseListState.failure(
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
