import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/transfer_branch/detail/transfer_branch_detail_event.dart';
import 'package:admart_app/blocs/transfer_branch/detail/transfer_branch_detail_state.dart';
import 'package:admart_app/models/transfer_branch_detail_response.dart';
import 'package:admart_app/models/transfer_branch_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/transfer_branch_detail_response.dart'
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
      var issueId = event.issueId;
      var issueNo = event.issueNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield TransferBranchDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        TransferBranchDetailScanResponse response =
            await _repository.transferBranchDetail_Scan(qrResult);
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
                errorMessage: '${qrResult} tidak di temukan di gudang  (1)',
                data: event.data,
              );
            } else {
              if (response.data.id == 0) {
                yield TransferBranchDetailState.failure(
                  errorMessage: '${qrResult} tidak di temukan di gudang (2)',
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
