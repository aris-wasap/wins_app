import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_receipt/detail_item_detail/goods_receipt_detail_item_detail_event.dart';
import 'package:wins_app/blocs/goods_receipt/detail_item_detail/goods_receipt_detail_item_detail_state.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:wins_app/models/goods_receipt_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';

class GoodsReceiptDetailItemDetailBloc extends BlocEventStateBase<
    GoodsReceiptDetailItemDetailEvent, GoodsReceiptDetailItemDetailState> {
  GoodsReceiptDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: GoodsReceiptDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsReceiptDetailItemDetailState> eventHandler(
      GoodsReceiptDetailItemDetailEvent event,
      GoodsReceiptDetailItemDetailState currentState) async* {
    if (event is GoodsReceiptDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield GoodsReceiptDetailItemDetailState.success(
        data: newData,
      );
    } else if (event is GoodsReceiptDetailItemDetailEventScan) {
      var id = event.id;
      var detId = event.detId;
      var webId = event.webId;
      var sapGoodsIssueId = event.sapGoodsIssueId;
      var woId = event.woId;
      var woLineNo = event.woLineNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;
      if (newData.batchs == null) {
        newData.batchs = [];
      }
      yield GoodsReceiptDetailItemDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsReceiptDetailScanResponse response =
            await _repository.goodsReceiptDetail_ScanItemBatch(
                id, detId, webId, sapGoodsIssueId, woId, woLineNo, qrResult);
        if (response == null) {
          yield GoodsReceiptDetailItemDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsReceiptDetailItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield GoodsReceiptDetailItemDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang  (1)',
                data: event.data,
              );
            } else {
              yield GoodsReceiptDetailItemDetailState.success(
                data: response.data,
                // newData : response.data,
              );
            }
          }
        }
      } catch (e) {
        yield GoodsReceiptDetailItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsReceiptDetailItemDetailEventRemoveContent) {
      yield GoodsReceiptDetailItemDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsReceiptDetailScanResponse response =
            await _repository.goodsReceiptDetail_RemoveContent(
                event.id, event.detId, event.detDetId);
        if (response == null) {
          yield GoodsReceiptDetailItemDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsReceiptDetailItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            currentState.data.batchs
                .removeWhere((content) => content.detDetId == event.detDetId);
            yield GoodsReceiptDetailItemDetailState.success(
                errorMessage: response.errorMessage,
                // dataNew: response.data,
                data: response.data);
          }
        }
      } catch (e) {
        yield GoodsReceiptDetailItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else {}
  }
}
