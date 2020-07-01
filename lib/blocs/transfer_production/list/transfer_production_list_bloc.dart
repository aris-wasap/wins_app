import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/transfer_production/list/transfer_production_list_event.dart';
import 'package:admart_app/blocs/transfer_production/list/transfer_production_list_state.dart';
import 'package:admart_app/models/transfer_production_list_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TransferProductionListBloc
    extends BlocEventStateBase<TransferProductionListEvent, TransferProductionListState> {
  TransferProductionListBloc()
      : super(
          initialState: TransferProductionListState.noAction(),
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
  Stream<TransferProductionListState> eventHandler(TransferProductionListEvent event,
      TransferProductionListState currentState) async* {
    switch (event.event) {
      case TransferProductionListEventType.activedSearch:
        {
          yield TransferProductionListState.success(
              data: currentState.data, isActiveSearch: true);
        }

        break;
      case TransferProductionListEventType.deactivedSearch:
        {
          yield TransferProductionListState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            TransferProductionListResponse response =
                await _repository.transferProductionList_FetchNextPage(0, "");
            if (response == null) {
              yield TransferProductionListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferProductionListState.failure(
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

                yield TransferProductionListState.success(
                    data: response.data, isActiveSearch: false);
              }
            }
          } catch (e) {
            yield TransferProductionListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case TransferProductionListEventType.firstPage:
        {
          yield TransferProductionListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferProductionListResponse response = await _repository
                .transferProductionList_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield TransferProductionListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferProductionListState.failure(
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
                yield TransferProductionListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferProductionListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferProductionListEventType.nextPage:
        {
          yield TransferProductionListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferProductionListResponse response =
                await _repository.transferProductionList_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferProductionListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferProductionListState.failure(
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
                yield TransferProductionListState.success(
                    data: data, isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferProductionListState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case TransferProductionListEventType.refresh:
        {
          yield TransferProductionListState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            TransferProductionListResponse response =
                await _repository.transferProductionList_Refresh(
                    _lastIdController.value, event.searchQuery);
            if (response == null) {
              yield TransferProductionListState.failure(
                  errorMessage: 'Response null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              bool error = response.error;
              if (error) {
                yield TransferProductionListState.failure(
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
                yield TransferProductionListState.success(
                    data: response.data,
                    isActiveSearch: currentState.isActiveSearch);
              }
            }
          } catch (e) {
            yield TransferProductionListState.failure(
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
