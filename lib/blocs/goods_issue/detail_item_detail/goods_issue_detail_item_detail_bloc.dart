import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail/goods_issue_detail_item_detail_event.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail/goods_issue_detail_item_detail_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:wins_app/models/goods_issue_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
//import 'package:wins_app/models/goods_issue_detail_response.dart' ;

class GoodsIssueDetailItemDetailBloc extends BlocEventStateBase<
    GoodsIssueDetailItemDetailEvent, GoodsIssueDetailItemDetailState> {
  GoodsIssueDetailItemDetailBloc(
    Item data,
  ) : super(
          initialState: GoodsIssueDetailItemDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsIssueDetailItemDetailState> eventHandler(
      GoodsIssueDetailItemDetailEvent event,
      GoodsIssueDetailItemDetailState currentState) async* {
    if (event is GoodsIssueDetailItemDetailEventQty) {
      var newData = currentState.data;
      newData.qty = event.qty;
      newData.binAbs = event.binAbs;
      newData.binCode = event.binCode;
      yield GoodsIssueDetailItemDetailState.success(
        data: newData,
      );
    } else if (event is GoodsIssueDetailItemDetailEventScan) {
      var id = event.id;
      var detId = event.detId;
      var woId = event.woId;
      var woLineNo = event.woLineNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;
      if (newData.batchs == null) {
        newData.batchs = [];
      }
      yield GoodsIssueDetailItemDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailScanResponse response =
            await _repository.goodsIssueDetail_ScanItemBatch(
                id, detId, woId, woLineNo, qrResult);
        if (response == null) {
          yield GoodsIssueDetailItemDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield GoodsIssueDetailItemDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang  (1)',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailItemDetailState.success(
                data: response.data,
                // newData : response.data,
              );
            }
          }
        }
      } catch (e) {
        yield GoodsIssueDetailItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueDetailItemDetailEventRemoveContent) {
      yield GoodsIssueDetailItemDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailScanResponse response =
            await _repository.goodsIssueDetail_RemoveContent(
                event.id, event.detId, event.detDetId);
        if (response == null) {
          yield GoodsIssueDetailItemDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailItemDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            currentState.data.batchs
                .removeWhere((content) => content.detDetId == event.detDetId);
            yield GoodsIssueDetailItemDetailState.success(
                errorMessage: response.errorMessage,
                // dataNew: response.data,
                data: response.data);
          }
        }
      } catch (e) {
        yield GoodsIssueDetailItemDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueDetailItemDetailEventRefreshDetail) {
      var detId = event.detId;
      var woLineNo = event.woLineNo;
      var newData = currentState.data;
      //var listData = currentState.data.batchs;

      if (detId == 0) {
        yield GoodsIssueDetailItemDetailState.success(
          data: newData,
        );
      } else {
        yield GoodsIssueDetailItemDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueDetailScanResponse response = await _repository
              .goodsIssueDetailItemDetail_RefreshDetail(detId, woLineNo);
          if (response == null) {
            yield GoodsIssueDetailItemDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueDetailItemDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailItemDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueDetailItemDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else {}
  }
}
