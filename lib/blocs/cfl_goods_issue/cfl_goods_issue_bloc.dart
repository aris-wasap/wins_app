import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/cfl_goods_issue/cfl_goods_issue_event.dart';
import 'package:ncf_app/blocs/cfl_goods_issue/cfl_goods_issue_state.dart';
import 'package:ncf_app/models/cfl_goods_issue_response.dart'; 
import 'package:ncf_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflGoodsIssueBloc extends BlocEventStateBase<CflGoodsIssueEvent, CflGoodsIssueState> {
  CflGoodsIssueBloc()
      : super(
          initialState: CflGoodsIssueState.noAction(),
        ); 
 
  @override
  void dispose() { 

    super.dispose();
  }

  @override
  Stream<CflGoodsIssueState> eventHandler(
      CflGoodsIssueEvent event, CflGoodsIssueState currentState) async* {
    switch (event.event) {
      case CflGoodsIssueEventType.activedSearch:
        yield CflGoodsIssueState.success(
          data: currentState.data,
          isActiveSearch: true,
          selectedRows: currentState.selectedRows,
        );

        break;
      case CflGoodsIssueEventType.deactivedSearch:
        {
          yield CflGoodsIssueState.busy(
            data: currentState.data,
            isActiveSearch: false,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflGoodsIssueResponse response = await _repository
                .cflGoodsIssue_FetchNextPage(0,  "");
            if (response == null) {
              yield CflGoodsIssueState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: false,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflGoodsIssueState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              } else { 

                yield CflGoodsIssueState.success(
                  data: response.data,
                  isActiveSearch: false,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflGoodsIssueState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: false,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflGoodsIssueEventType.firstPage:
        { 

          yield CflGoodsIssueState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflGoodsIssueResponse response =
                await _repository.cflGoodsIssue_FetchNextPage(
                    0,  event.searchQuery);
            if (response == null) {
              yield CflGoodsIssueState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflGoodsIssueState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflGoodsIssueState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflGoodsIssueState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflGoodsIssueEventType.nextPage:
        {
          yield CflGoodsIssueState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflGoodsIssueResponse response =
                await _repository.cflGoodsIssue_FetchNextPage(
                    currentState.data.length, 
                    event.searchQuery);
            if (response == null) {
              yield CflGoodsIssueState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflGoodsIssueState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                
                var data = currentState.data;
                data.addAll(response.data);
                yield CflGoodsIssueState.success(
                  data: data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflGoodsIssueState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflGoodsIssueEventType.refresh:
        {
          yield CflGoodsIssueState.busy(
            data: currentState.data,
            isActiveSearch: currentState.isActiveSearch,
            selectedRows: currentState.selectedRows,
          );
          try {
            var _repository = Repository();
            CflGoodsIssueResponse response = await _repository.cflGoodsIssue_FetchNextPage(
               0, 
                event.searchQuery);
            if (response == null) {
              yield CflGoodsIssueState.failure(
                errorMessage: 'Response null',
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch,
                selectedRows: currentState.selectedRows,
              );
            } else {
              bool error = response.error;
              if (error) {
                yield CflGoodsIssueState.failure(
                  errorMessage: 'Fetch fail ${response.errorMessage}',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              } else {
                 
                yield CflGoodsIssueState.success(
                  data: response.data,
                  isActiveSearch: currentState.isActiveSearch,
                  selectedRows: currentState.selectedRows,
                );
              }
            }
          } catch (e) {
            yield CflGoodsIssueState.failure(
              errorMessage: "fail ${event.event}",
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch,
              selectedRows: currentState.selectedRows,
            );
          }
        }
        break;
      case CflGoodsIssueEventType.selectedRow:
        {
          if (currentState.selectedRows.contains(event.selectedRow)) {
            currentState.selectedRows.remove(event.selectedRow);
          } else {
            currentState.selectedRows.add(event.selectedRow);
          }
          yield CflGoodsIssueState.success(
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
