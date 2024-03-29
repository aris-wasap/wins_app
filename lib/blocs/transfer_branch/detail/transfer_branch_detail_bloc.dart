import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/transfer_branch/detail/transfer_branch_detail_event.dart';
import 'package:wins_app/blocs/transfer_branch/detail/transfer_branch_detail_state.dart';
import 'package:wins_app/models/transfer_branch_detail_response.dart';
import 'package:wins_app/models/transfer_branch_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/transfer_branch_detail_response.dart'
    as transferBranchDetail;

class TransferBranchDetailBloc extends BlocEventStateBase<
    TransferBranchDetailEvent, TransferBranchDetailState> {
  TransferBranchDetailBloc()
      : super(
          initialState: TransferBranchDetailState.noAction(),
        );

  @override
  Stream<TransferBranchDetailState> eventHandler(
      TransferBranchDetailEvent event,
      TransferBranchDetailState currentState) async* {
    if (event is TransferBranchDetailEventNormal) {
      yield TransferBranchDetailState.success(
        data: currentState.data,
      );
    } else if (event is TransferBranchDetailEventGetId) {
      if (event.id == 0) {
        yield TransferBranchDetailState.success(
          data: Data(items: List<transferBranchDetail.Item>()),
        );
      } else {
        yield TransferBranchDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          TransferBranchDetailResponse response =
              await _repository.transferBranchDetail_GetById(event.id);
          if (response == null) {
            yield TransferBranchDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield TransferBranchDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield TransferBranchDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield TransferBranchDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is TransferBranchDetailEventScan) {
      var requestId = event.requestId;
      var requestNo = event.requestNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield TransferBranchDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        TransferBranchDetailScanResponse response =
            await _repository.transferBranchDetail_Scan(requestId, qrResult);
        if (response == null) {
          yield TransferBranchDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferBranchDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield TransferBranchDetailState.failure(
                errorMessage:
                    'Item Batch Number ${qrResult} tidak di temukan dari Transfer Request ${requestNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data == null) {
                yield TransferBranchDetailState.failure(
                  errorMessage:
                      'Item Batch Number ${qrResult} tidak di temukan dari Transfer Request ${requestNo} (2)',
                  data: event.data,
                );
              } else {
                yield TransferBranchDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield TransferBranchDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferBranchDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield TransferBranchDetailState.success(
        data: newData,
      );
    } else if (event is TransferBranchDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield TransferBranchDetailState.success(
        data: newData,
      );
    } else if (event is TransferBranchDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield TransferBranchDetailState.success(
        data: newData,
      );
    } else if (event is TransferBranchDetailEventAdd) {
      yield TransferBranchDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        TransferBranchDetailResponse response =
            await _repository.transferBranchDetail_Add(event.data);
        if (response == null) {
          yield TransferBranchDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferBranchDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield TransferBranchDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<transferBranchDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield TransferBranchDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferBranchDetailEventPost) {
      yield TransferBranchDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        TransferBranchDetailResponse response =
            await _repository.transferBranchDetail_Post(event.data);
        if (response == null) {
          yield TransferBranchDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield TransferBranchDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield TransferBranchDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<transferBranchDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield TransferBranchDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is TransferBranchDetailEventCancel) {
      yield TransferBranchDetailState.busy(
        data: currentState.data,
      );

      yield TransferBranchDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
