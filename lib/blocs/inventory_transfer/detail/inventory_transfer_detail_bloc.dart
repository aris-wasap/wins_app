import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/inventory_transfer/detail/inventory_transfer_detail_event.dart';
import 'package:admart_app/blocs/inventory_transfer/detail/inventory_transfer_detail_state.dart';
import 'package:admart_app/models/inventory_transfer_detail_response.dart';
import 'package:admart_app/models/inventory_transfer_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/inventory_transfer_detail_response.dart'
    as inventoryTransferDetail;

class InventoryTransferDetailBloc extends BlocEventStateBase<
    InventoryTransferDetailEvent, InventoryTransferDetailState> {
  InventoryTransferDetailBloc()
      : super(
          initialState: InventoryTransferDetailState.noAction(),
        );

  @override
  Stream<InventoryTransferDetailState> eventHandler(
      InventoryTransferDetailEvent event,
      InventoryTransferDetailState currentState) async* {
    if (event is InventoryTransferDetailEventNormal) {
      yield InventoryTransferDetailState.success(
        data: currentState.data,
      );
    } else if (event is InventoryTransferDetailEventGetId) {
      if (event.id == 0) {
        yield InventoryTransferDetailState.success(
          data: Data(items: List<inventoryTransferDetail.Item>()),
        );
      } else {
        yield InventoryTransferDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          InventoryTransferDetailResponse response =
              await _repository.inventoryTransferDetail_GetById(event.id);
          if (response == null) {
            yield InventoryTransferDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield InventoryTransferDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield InventoryTransferDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield InventoryTransferDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is InventoryTransferDetailEventScan) {
      var requestId = event.requestId;
      var requestNo = event.requestNo;
      var whsCodeFrom = event.whsCodeFrom;
      var absEntryFrom = event.absEntryFrom;
      var binCodeFrom = event.binCodeFrom;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield InventoryTransferDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        InventoryTransferDetailScanResponse response =
            await _repository.inventoryTransferDetail_Scan(
                requestId, whsCodeFrom, absEntryFrom, binCodeFrom, qrResult);
        if (response == null) {
          yield InventoryTransferDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield InventoryTransferDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield InventoryTransferDetailState.failure(
                errorMessage:
                    'Item Batch Number ${qrResult} tidak di temukan di gudang ${whsCodeFrom}-bin ${binCodeFrom} dan inventory transfer request ${requestNo} ',
                data: event.data,
              );
            } else {
              // if (response.data.soId == 0) {
              //   yield InventoryTransferDetailState.failure(
              //     errorMessage: 'Tidak di temukan di system(2)',
              //     data: event.data,
              //   );
              // } else {
              // newData.items.add(response.data);
              yield InventoryTransferDetailState.success(
                data: newData,
                newItem: response.data,
              );
              // }
            }
          }
        }
      } catch (e) {
        yield InventoryTransferDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is InventoryTransferDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield InventoryTransferDetailState.success(
        data: newData,
      );
    } else if (event is InventoryTransferDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield InventoryTransferDetailState.success(
        data: newData,
      );
    } else if (event is InventoryTransferDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield InventoryTransferDetailState.success(
        data: newData,
      );
    } else if (event is InventoryTransferDetailEventAdd) {
      yield InventoryTransferDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        InventoryTransferDetailResponse response =
            await _repository.inventoryTransferDetail_Add(event.data);
        if (response == null) {
          yield InventoryTransferDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield InventoryTransferDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield InventoryTransferDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<inventoryTransferDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield InventoryTransferDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is InventoryTransferDetailEventPost) {
      yield InventoryTransferDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        InventoryTransferDetailResponse response =
            await _repository.inventoryTransferDetail_Post(event.data);
        if (response == null) {
          yield InventoryTransferDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield InventoryTransferDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield InventoryTransferDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<inventoryTransferDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield InventoryTransferDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }else if (event is InventoryTransferDetailEventCancel) {
      yield InventoryTransferDetailState.busy(
        data: currentState.data,
      );

      yield InventoryTransferDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
