import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/receipt_issue/detail/receipt_issue_detail_event.dart';
import 'package:ncf_app/blocs/receipt_issue/detail/receipt_issue_detail_state.dart';
import 'package:ncf_app/models/receipt_issue_detail_response.dart';
import 'package:ncf_app/models/receipt_issue_detail_scan_response.dart';
import 'package:ncf_app/resources/repository.dart';
import 'package:ncf_app/models/receipt_issue_detail_response.dart'
    as receiptIssueDetail;

class ReceiptIssueDetailBloc extends BlocEventStateBase<
    ReceiptIssueDetailEvent, ReceiptIssueDetailState> {
  ReceiptIssueDetailBloc()
      : super(
          initialState: ReceiptIssueDetailState.noAction(),
        );

  @override
  Stream<ReceiptIssueDetailState> eventHandler(ReceiptIssueDetailEvent event,
      ReceiptIssueDetailState currentState) async* {
    if (event is ReceiptIssueDetailEventNormal) {
      yield ReceiptIssueDetailState.success(
        data: currentState.data,
      );
    } else if (event is ReceiptIssueDetailEventGetId) {
      if (event.id == 0) {
        yield ReceiptIssueDetailState.success(
          data: Data(items: List<receiptIssueDetail.Item>()),
        );
      } else {
        yield ReceiptIssueDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          ReceiptIssueDetailResponse response =
              await _repository.receiptIssueDetail_GetById(event.id);
          if (response == null) {
            yield ReceiptIssueDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield ReceiptIssueDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield ReceiptIssueDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield ReceiptIssueDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is ReceiptIssueDetailEventScan) {
      var issueId = event.issueId;
      var issueNo = event.issueNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield ReceiptIssueDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ReceiptIssueDetailScanResponse response =
            await _repository.receiptIssueDetail_Scan(issueId, qrResult);
        if (response == null) {
          yield ReceiptIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield ReceiptIssueDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang dan Issue No. ${issueNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.issueId == 0) {
                yield ReceiptIssueDetailState.failure(
                  errorMessage: '${qrResult} tidak di temukan di gudang dan Issue No. ${issueNo} (2)',
                  data: event.data,
                );
              } else {
                yield ReceiptIssueDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield ReceiptIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is ReceiptIssueDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield ReceiptIssueDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptIssueDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield ReceiptIssueDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptIssueDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield ReceiptIssueDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptIssueDetailEventAdd) {
      yield ReceiptIssueDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReceiptIssueDetailResponse response =
            await _repository.receiptIssueDetail_Add(event.data);
        if (response == null) {
          yield ReceiptIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReceiptIssueDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<receiptIssueDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReceiptIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReceiptIssueDetailEventCancel) {
      yield ReceiptIssueDetailState.busy(
        data: currentState.data,
      );

      yield ReceiptIssueDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
