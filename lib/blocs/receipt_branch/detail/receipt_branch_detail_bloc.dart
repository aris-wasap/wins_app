import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/receipt_branch/detail/receipt_branch_detail_event.dart';
import 'package:admart_app/blocs/receipt_branch/detail/receipt_branch_detail_state.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart';
import 'package:admart_app/models/receipt_branch_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart'
    as receiptBranchDetail;

class ReceiptBranchDetailBloc extends BlocEventStateBase<
    ReceiptBranchDetailEvent, ReceiptBranchDetailState> {
  ReceiptBranchDetailBloc()
      : super(
          initialState: ReceiptBranchDetailState.noAction(),
        );

  @override
  Stream<ReceiptBranchDetailState> eventHandler(ReceiptBranchDetailEvent event,
      ReceiptBranchDetailState currentState) async* {
    if (event is ReceiptBranchDetailEventNormal) {
      yield ReceiptBranchDetailState.success(
        data: currentState.data,
      );
    } else if (event is ReceiptBranchDetailEventGetId) {
      if (event.id == 0) {
        yield ReceiptBranchDetailState.success(
          data: Data(items: List<receiptBranchDetail.Item>()),
        );
      } else {
        yield ReceiptBranchDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          ReceiptBranchDetailResponse response =
              await _repository.receiptBranchDetail_GetById(event.id);
          if (response == null) {
            yield ReceiptBranchDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield ReceiptBranchDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield ReceiptBranchDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield ReceiptBranchDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is ReceiptBranchDetailEventScan) {
      var issueId = event.issueId;
      var issueNo = event.issueNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield ReceiptBranchDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        ReceiptBranchDetailScanResponse response =
            await _repository.receiptBranchDetail_Scan(issueId, qrResult);
        if (response == null) {
          yield ReceiptBranchDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptBranchDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield ReceiptBranchDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang dan Issue No. ${issueNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.issueId == 0) {
                yield ReceiptBranchDetailState.failure(
                  errorMessage: '${qrResult} tidak di temukan di gudang dan Issue No. ${issueNo} (2)',
                  data: event.data,
                );
              } else {
                yield ReceiptBranchDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield ReceiptBranchDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is ReceiptBranchDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield ReceiptBranchDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptBranchDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield ReceiptBranchDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptBranchDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield ReceiptBranchDetailState.success(
        data: newData,
      );
    } else if (event is ReceiptBranchDetailEventAdd) {
      yield ReceiptBranchDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        ReceiptBranchDetailResponse response =
            await _repository.receiptBranchDetail_Add(event.data);
        if (response == null) {
          yield ReceiptBranchDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield ReceiptBranchDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield ReceiptBranchDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<receiptBranchDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield ReceiptBranchDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is ReceiptBranchDetailEventCancel) {
      yield ReceiptBranchDetailState.busy(
        data: currentState.data,
      );

      yield ReceiptBranchDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
