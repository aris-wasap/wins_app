import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/cfl_purchase_reference/cfl_purchase_reference_event.dart';
import 'package:wins_app/blocs/cfl_purchase_reference/cfl_purchase_reference_state.dart';
import 'package:wins_app/models/cfl_purchase_reference_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:rxdart/rxdart.dart';

class CflPurchaseReferenceBloc extends BlocEventStateBase<
    CflPurchaseReferenceEvent, CflPurchaseReferenceState> {
  CflPurchaseReferenceBloc()
      : super(
          initialState: CflPurchaseReferenceState.noAction(),
        );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<CflPurchaseReferenceState> eventHandler(
      CflPurchaseReferenceEvent event,
      CflPurchaseReferenceState currentState) async* {
    switch (event.event) {
      case CflPurchaseReferenceEventType.activedSearch:
        yield CflPurchaseReferenceState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflPurchaseReferenceEventType.deactivedSearch:
        {
          yield CflPurchaseReferenceState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPurchaseReferenceResponse response =
                await _repository.cflPurchaseReference_FetchNextPage(0, "", 0);
            if (response == null) {
              yield CflPurchaseReferenceState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPurchaseReferenceState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflPurchaseReferenceState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPurchaseReferenceState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPurchaseReferenceEventType.firstPage:
        {
          yield CflPurchaseReferenceState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPurchaseReferenceResponse response =
                await _repository.cflPurchaseReference_FetchNextPage(
                    0, event.searchQuery, event.poId);
            if (response == null) {
              yield CflPurchaseReferenceState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPurchaseReferenceState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflPurchaseReferenceState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPurchaseReferenceState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPurchaseReferenceEventType.nextPage:
        {
          yield CflPurchaseReferenceState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPurchaseReferenceResponse response =
                await _repository.cflPurchaseReference_FetchNextPage(
                    currentState.data.length, event.searchQuery, event.poId);
            if (response == null) {
              yield CflPurchaseReferenceState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPurchaseReferenceState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                var data = currentState.data;
                data.addAll(response.data);
                yield CflPurchaseReferenceState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPurchaseReferenceState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPurchaseReferenceEventType.refresh:
        {
          yield CflPurchaseReferenceState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflPurchaseReferenceResponse response =
                await _repository.cflPurchaseReference_FetchNextPage(
                    0, event.searchQuery, event.poId);
            if (response == null) {
              yield CflPurchaseReferenceState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflPurchaseReferenceState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                yield CflPurchaseReferenceState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflPurchaseReferenceState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflPurchaseReferenceEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflPurchaseReferenceState.success(
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
