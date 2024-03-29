import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/request_issue/detail/request_issue_detail_event.dart';
import 'package:wins_app/blocs/request_issue/detail/request_issue_detail_state.dart';
import 'package:wins_app/models/request_issue_detail_response.dart';
import 'package:wins_app/models/request_issue_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/request_issue_detail_response.dart'
    as requestIssueDetail;

class RequestIssueDetailBloc extends BlocEventStateBase<RequestIssueDetailEvent,
    RequestIssueDetailState> {
  RequestIssueDetailBloc()
      : super(
          initialState: RequestIssueDetailState.noAction(),
        );

  @override
  Stream<RequestIssueDetailState> eventHandler(RequestIssueDetailEvent event,
      RequestIssueDetailState currentState) async* {
    if (event is RequestIssueDetailEventNormal) {
      yield RequestIssueDetailState.success(
        data: currentState.data,
      );
    } else if (event is RequestIssueDetailEventGetId) {
      if (event.id == 0) {
        yield RequestIssueDetailState.success(
          data: Data(items: List<requestIssueDetail.Item>()),
        );
      } else {
        yield RequestIssueDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          RequestIssueDetailResponse response =
              await _repository.requestIssueDetail_GetById(event.id);
          if (response == null) {
            yield RequestIssueDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield RequestIssueDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield RequestIssueDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield RequestIssueDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is RequestIssueDetailEventScan) {
      var requestId = event.requestId;
      var requestNo = event.requestNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield RequestIssueDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        RequestIssueDetailScanResponse response =
            await _repository.requestIssueDetail_Scan(requestId, qrResult);
        if (response == null) {
          yield RequestIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield RequestIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield RequestIssueDetailState.failure(
                errorMessage:
                    'Batch Number ${qrResult} tidak di temukan dari Issue No. ${requestNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.requestId == 0) {
                yield RequestIssueDetailState.failure(
                  errorMessage:
                      'Batch Number ${qrResult} tidak di temukan dari Issue No. ${requestNo} (2)',
                  data: event.data,
                );
              } else {
                yield RequestIssueDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield RequestIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is RequestIssueDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield RequestIssueDetailState.success(
        data: newData,
      );
    } else if (event is RequestIssueDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield RequestIssueDetailState.success(
        data: newData,
      );
    } else if (event is RequestIssueDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield RequestIssueDetailState.success(
        data: newData,
      );
    } else if (event is RequestIssueDetailEventAdd) {
      yield RequestIssueDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        RequestIssueDetailResponse response =
            await _repository.requestIssueDetail_Add(event.data);
        if (response == null) {
          yield RequestIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield RequestIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield RequestIssueDetailState.success(
              succesMessage: response.errorMessage,
              data:
                  response.data ?? Data(items: List<requestIssueDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield RequestIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is RequestIssueDetailEventUpdate) {
      yield RequestIssueDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        RequestIssueDetailResponse response =
            await _repository.requestIssueDetail_Update(event.data);
        if (response == null) {
          yield RequestIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield RequestIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield RequestIssueDetailState.success(
              succesMessage: response.errorMessage,
              data:
                  response.data ?? Data(items: List<requestIssueDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield RequestIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is RequestIssueDetailEventPost) {
      yield RequestIssueDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        RequestIssueDetailResponse response =
            await _repository.requestIssueDetail_Post(event.data);
        if (response == null) {
          yield RequestIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield RequestIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield RequestIssueDetailState.success(
              succesMessage: response.errorMessage,
              data:
                  response.data ?? Data(items: List<requestIssueDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield RequestIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }else if (event is RequestIssueDetailEventRemoveItem) {
      yield RequestIssueDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        RequestIssueDetailResponse response = await _repository
            .requestIssueDetail_RemoveItem(event.id, event.detId);
        if (response == null) {
          yield RequestIssueDetailState.failure(
            errorMessage: 'Response null',
            data: currentState.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield RequestIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: currentState.data,
            );
          } else {
            yield RequestIssueDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data,
            );
          }
        }
      } catch (e) {
        yield RequestIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: currentState.data,
        );
      }
    } else if (event is RequestIssueDetailEventCancel) {
      yield RequestIssueDetailState.busy(
        data: currentState.data,
      );

      yield RequestIssueDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
