import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/cfl_goods_return_request/cfl_goods_return_request_event.dart';
import 'package:wins_app/blocs/cfl_goods_return_request/cfl_goods_return_request_state.dart';
import 'package:wins_app/models/cfl_goods_return_request_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:rxdart/rxdart.dart';

class CflGoodsReturnRequestBloc extends BlocEventStateBase<
    CflGoodsReturnRequestEvent, CflGoodsReturnRequestState> {
  CflGoodsReturnRequestBloc()
      : super(
          initialState: CflGoodsReturnRequestState.noAction(),
        );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<CflGoodsReturnRequestState> eventHandler(
      CflGoodsReturnRequestEvent event,
      CflGoodsReturnRequestState currentState) async* {
    switch (event.event) {
      case CflGoodsReturnRequestEventType.activedSearch:
        yield CflGoodsReturnRequestState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflGoodsReturnRequestEventType.deactivedSearch:
        {
          yield CflGoodsReturnRequestState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflGoodsReturnRequestResponse response =
                await _repository.cflGoodsReturnRequest_FetchNextPage(0, "");
            if (response == null) {
              yield CflGoodsReturnRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflGoodsReturnRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflGoodsReturnRequestState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflGoodsReturnRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflGoodsReturnRequestEventType.firstPage:
        {
          yield CflGoodsReturnRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflGoodsReturnRequestResponse response = await _repository
                .cflGoodsReturnRequest_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield CflGoodsReturnRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflGoodsReturnRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflGoodsReturnRequestState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflGoodsReturnRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflGoodsReturnRequestEventType.nextPage:
        {
          yield CflGoodsReturnRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflGoodsReturnRequestResponse response =
                await _repository.cflGoodsReturnRequest_FetchNextPage(
                    currentState.data.length, event.searchQuery);
            if (response == null) {
              yield CflGoodsReturnRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflGoodsReturnRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                var data = currentState.data;
                data.addAll(response.data);
                yield CflGoodsReturnRequestState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflGoodsReturnRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflGoodsReturnRequestEventType.refresh:
        {
          yield CflGoodsReturnRequestState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflGoodsReturnRequestResponse response = await _repository
                .cflGoodsReturnRequest_FetchNextPage(0, event.searchQuery);
            if (response == null) {
              yield CflGoodsReturnRequestState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflGoodsReturnRequestState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflGoodsReturnRequestState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflGoodsReturnRequestState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflGoodsReturnRequestEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflGoodsReturnRequestState.success(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
        }

        break;
      default:
        {}
    }
  }
}
