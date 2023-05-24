import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail_item_batch_detail/goods_issue_mixing_detail_item_batch_detail_event.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail_item_batch_detail/goods_issue_mixing_detail_item_batch_detail_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_scan_batch_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:wins_app/models/goods_issue_mixing_detail_response.dart' ;

class GoodsIssueMixingDetailItemBatchDetailBloc extends BlocEventStateBase<
    GoodsIssueMixingDetailItemBatchDetailEvent,
    GoodsIssueMixingDetailItemBatchDetailState> {
  GoodsIssueMixingDetailItemBatchDetailBloc(
    ItemBatch data,
  ) : super(
          initialState:
              GoodsIssueMixingDetailItemBatchDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsIssueMixingDetailItemBatchDetailState> eventHandler(
      GoodsIssueMixingDetailItemBatchDetailEvent event,
      GoodsIssueMixingDetailItemBatchDetailState currentState) async* {
    if (event is GoodsIssueMixingDetailItemBatchDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield GoodsIssueMixingDetailItemBatchDetailState.success(
        data: newData,
      );
    } 
    // else if (event is GoodsIssueMixingDetailItemBatchDetailEventScanBatch) {
    //   var id = event.id;
    //   var detId = event.detId;
    //   var woId = event.woId;
    //   var woLineNo = event.woLineNo;
    //   var qrResult = event.qrResult;
    //   var newData = currentState.data;

    //   yield GoodsIssueMixingDetailItemBatchDetailState.busy(
    //     data: currentState.data,
    //   );
    //   try {
    //     var _repository = Repository();
    //     GoodsIssueMixingDetailScanBatchResponse response =
    //         await _repository.goodsIssueMixingDetail_ScanBatch(
    //       id,
    //       detId,
    //       woId,
    //       woLineNo,
    //       qrResult,
    //     );
    //     if (response == null) {
    //       yield GoodsIssueMixingDetailItemBatchDetailState.failure(
    //         errorMessage: 'Response null',
    //         data: event.data,
    //       );
    //     } else {
    //       bool error = response.error;
    //       if (error) {
    //         yield GoodsIssueMixingDetailItemBatchDetailState.failure(
    //           errorMessage: 'Fetch fail ${response.errorMessage}',
    //           data: event.data,
    //         );
    //       } else {
    //         if (response.dataBatch == null) {
    //           yield GoodsIssueMixingDetailItemBatchDetailState.failure(
    //             errorMessage: '$qrResult tidak di temukan di gudang  (1)',
    //             data: event.data,
    //           );
    //         } else {
    //           if (response.dataBatch.batchNo == null) {
    //             yield GoodsIssueMixingDetailItemBatchDetailState.failure(
    //               errorMessage: '$qrResult tidak di temukan di gudang (2)',
    //               data: event.data,
    //             );
    //           } else {
    //             yield GoodsIssueMixingDetailItemBatchDetailState.success(
    //               data: newData,
    //               // newItem: response.data,
    //             );
    //           }
    //         }
    //       }
    //     }
    //   } catch (e) {
    //     yield GoodsIssueMixingDetailItemBatchDetailState.failure(
    //       errorMessage: "fail ${event.toString()}",
    //       data: event.data,
    //     );
    //   }
    // }
     else {}
  }
}
