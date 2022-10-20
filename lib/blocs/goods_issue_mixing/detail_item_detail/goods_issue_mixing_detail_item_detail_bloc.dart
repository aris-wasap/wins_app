import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail_item_detail/goods_issue_mixing_detail_item_detail_event.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail_item_detail/goods_issue_mixing_detail_item_detail_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:wins_app/models/goods_issue_mixing_detail_response.dart' ;

class GoodsIssueMixingDetailItemDetailBloc extends BlocEventStateBase<
    GoodsIssueMixingDetailItemDetailEvent,
    GoodsIssueMixingDetailItemDetailState> {
  GoodsIssueMixingDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState:
              GoodsIssueMixingDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsIssueMixingDetailItemDetailState> eventHandler(
      GoodsIssueMixingDetailItemDetailEvent event,
      GoodsIssueMixingDetailItemDetailState currentState) async* {
    if (event is GoodsIssueMixingDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield GoodsIssueMixingDetailItemDetailState.success(
        data: newData,
      );
    } else if (event is GoodsIssueMixingDetailItemDetailEventScan) {
      var id = event.id;
      var detId = event.detId;
      var woId = event.woId;
      var woLineNo = event.woLineNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;
      if (newData.batchs == null) {
        newData.batchs = [];
      }
      yield GoodsIssueMixingDetailItemDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueMixingDetailScanResponse response =
            await _repository.goodsIssueMixingDetail_ScanItemBatch(
                id, detId, woId, woLineNo, qrResult);
        if (response == null) {
          yield GoodsIssueMixingDetailItemDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueMixingDetailItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield GoodsIssueMixingDetailItemDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang  (1)',
                data: event.data,
              );
            } else {
              yield GoodsIssueMixingDetailItemDetailState.success(
                data: response.data,
                // newData : response.data,
              );
            }
          }
        }
      } catch (e) {
        yield GoodsIssueMixingDetailItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueMixingDetailItemDetailEventRemoveContent) {
      yield GoodsIssueMixingDetailItemDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueMixingDetailScanResponse response =
            await _repository.goodsIssueMixingDetail_RemoveContent(
                event.id, event.detId, event.detDetId);
        if (response == null) {
          yield GoodsIssueMixingDetailItemDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueMixingDetailItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            currentState.data.batchs
                .removeWhere((content) => content.detDetId == event.detDetId);
            yield GoodsIssueMixingDetailItemDetailState.success(
                errorMessage: response.errorMessage,
                // dataNew: response.data,
                data: response.data);
          }
        }
      } catch (e) {
        yield GoodsIssueMixingDetailItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueMixingDetailItemDetailEventRefreshDetail) {
      var detId = event.detId;
      var woLineNo = event.woLineNo;
      var newData = currentState.data;
      //var listData = currentState.data.batchs;

      if (detId == 0) {
        yield GoodsIssueMixingDetailItemDetailState.success(
          data: newData,
        );
      } else {
        yield GoodsIssueMixingDetailItemDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueMixingDetailScanResponse response = await _repository
              .goodsIssueMixingDetailItemDetail_RefreshDetail(detId, woLineNo);
          if (response == null) {
            yield GoodsIssueMixingDetailItemDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueMixingDetailItemDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueMixingDetailItemDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueMixingDetailItemDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else {}
  }
}
