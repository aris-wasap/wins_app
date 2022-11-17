import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_additional_detail/goods_issue_detail_item_additional_detail_event.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_additional_detail/goods_issue_detail_item_additional_detail_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:wins_app/models/goods_issue_detail_scan_response.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart'
    as goodsIssueDetail;

import 'package:wins_app/resources/repository.dart';
//import 'package:wins_app/models/goods_issue_detail_response.dart' ;

class GoodsIssueDetailItemAdditionalDetailBloc extends BlocEventStateBase<
    GoodsIssueDetailItemAdditionalDetailEvent,
    GoodsIssueDetailItemAdditionalDetailState> {
  GoodsIssueDetailItemAdditionalDetailBloc(
    Item data,
  ) : super(
          initialState:
              GoodsIssueDetailItemAdditionalDetailState.noAction(data: data),
        );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Stream<GoodsIssueDetailItemAdditionalDetailState> eventHandler(
      GoodsIssueDetailItemAdditionalDetailEvent event,
      GoodsIssueDetailItemAdditionalDetailState currentState) async* {
    if (event is GoodsIssueDetailItemAdditionalDetailEventQty) {
      var newData = currentState.data;
      if (newData != null) {
        newData.qty = event.qty;
        newData.woQty = event.qty;
        newData.binAbs = event.binAbs;
        newData.binCode = event.binCode;
      }
      yield GoodsIssueDetailItemAdditionalDetailState.success(
        data: newData ?? Item(batchs: List<goodsIssueDetail.ItemBatch>()),
      );
    } else if (event
        is GoodsIssueDetailItemAdditionalDetailEventCreateAdditionalItemDetail) {
      var woId = event.woId;
      var id = event.id;
      var detId = event.detId;
      var itemCode = event.itemCode;
      var plannedQty = event.plannedQty;
      var whsCode = event.whsCode;
      var binAbs = event.binAbs;
      var binCode = event.binCode;
      // var newData = currentState.data;

      // if (detId != null) {

      // }
      yield GoodsIssueDetailItemAdditionalDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailScanResponse response =
            await _repository.goodsIssueDetail_CreateAdditionalItem(
          woId,
          id,
          detId,
          itemCode,
          plannedQty,
          whsCode,
          binAbs,
          binCode,
        );
        if (response == null) {
          yield GoodsIssueDetailItemAdditionalDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailItemAdditionalDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield GoodsIssueDetailItemAdditionalDetailState.success(
              data: response.data ??
                  Item(batchs: List<goodsIssueDetail.ItemBatch>()),
            );
          }
        }
      } catch (e) {
        yield GoodsIssueDetailItemAdditionalDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueDetailItemAdditionalDetailEventScan) {
      var id = event.id;
      var detId = event.detId;
      var woId = event.woId;
      var woLineNo = event.woLineNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;
      if (newData.batchs == null) {
        newData.batchs = [];
      }
      yield GoodsIssueDetailItemAdditionalDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailScanResponse response =
            await _repository.goodsIssueDetail_ScanItemBatch(
                id, detId, woId, woLineNo, qrResult);
        if (response == null) {
          yield GoodsIssueDetailItemAdditionalDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailItemAdditionalDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield GoodsIssueDetailItemAdditionalDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang  (1)',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailItemAdditionalDetailState.success(
                data: response.data,
                // newData : response.data,
              );
            }
          }
        }
      } catch (e) {
        yield GoodsIssueDetailItemAdditionalDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event
        is GoodsIssueDetailItemAdditionalDetailEventRemoveContent) {
      yield GoodsIssueDetailItemAdditionalDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailScanResponse response =
            await _repository.goodsIssueDetail_RemoveContent(
                event.id, event.detId, event.detDetId);
        if (response == null) {
          yield GoodsIssueDetailItemAdditionalDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailItemAdditionalDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            currentState.data.batchs
                .removeWhere((content) => content.detDetId == event.detDetId);
            yield GoodsIssueDetailItemAdditionalDetailState.success(
                errorMessage: response.errorMessage,
                // dataNew: response.data,
                data: response.data);
          }
        }
      } catch (e) {
        yield GoodsIssueDetailItemAdditionalDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event
        is GoodsIssueDetailItemAdditionalDetailEventRefreshDetailAdditional) {
      var id = event.id;
      var detId = event.detId;
      var qty = event.qty;
      var newData = currentState.data;
      //var listData = currentState.data.batchs;

      if (detId == 0) {
        yield GoodsIssueDetailItemAdditionalDetailState.success(
          data: newData,
        );
      } else {
        yield GoodsIssueDetailItemAdditionalDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueDetailScanResponse response = await _repository
              .goodsIssueDetailItemDetail_RefreshDetailAdditional(
                  id, detId, qty);
          if (response == null) {
            yield GoodsIssueDetailItemAdditionalDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueDetailItemAdditionalDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailItemAdditionalDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueDetailItemAdditionalDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsIssueDetailItemAdditionalDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.batchs[event.itemIndex] = event.itemBatch;
      // yield GoodsIssueDetailItemAdditionalDetailState.success(
      //   data: newData,
      // );
      yield GoodsIssueDetailItemAdditionalDetailState.busy(
        data: newData,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailScanResponse response =
            await _repository.goodsIssueDetail_UpdateDetailBatch(newData);
        if (response == null) {
          yield GoodsIssueDetailItemAdditionalDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailItemAdditionalDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            // currentState.data.batchs
            //     .removeWhere((content) => content.detDetId == event.detDetId);
            yield GoodsIssueDetailItemAdditionalDetailState.success(
              errorMessage: response.errorMessage,
              data: response.data,
            );
          }
        }
      } catch (e) {
        yield GoodsIssueDetailItemAdditionalDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else {}
  }
}
