import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail/goods_issue_mixing_detail_event.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail/goods_issue_mixing_detail_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_refresh_response.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart'
    as goodsIssueDetail;

class GoodsIssueMixingDetailBloc extends BlocEventStateBase<
    GoodsIssueMixingDetailEvent, GoodsIssueMixingDetailState> {
  GoodsIssueMixingDetailBloc()
      : super(
          initialState: GoodsIssueMixingDetailState.noAction(),
        );

  @override
  Stream<GoodsIssueMixingDetailState> eventHandler(
      GoodsIssueMixingDetailEvent event,
      GoodsIssueMixingDetailState currentState) async* {
    if (event is GoodsIssueMixingDetailEventNormal) {
      yield GoodsIssueMixingDetailState.success(
        data: currentState.data,
      );
    } else if (event is GoodsIssueMixingDetailEventGetId) {
      if (event.id == 0) {
        yield GoodsIssueMixingDetailState.success(
          data: Data(items: List<goodsIssueDetail.Item>()),
        );
      } else {
        yield GoodsIssueMixingDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueMixingDetailResponse response =
              await _repository.goodsIssueMixingDetail_GetById(event.id);
          if (response == null) {
            yield GoodsIssueMixingDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueMixingDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueMixingDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueMixingDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsIssueMixingDetailEventScan) {
      var woId = event.woId;
      var woNo = event.woNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield GoodsIssueMixingDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueMixingDetailScanResponse response =
            await _repository.goodsIssueMixingDetail_Scan(woId, qrResult);
        if (response == null) {
          yield GoodsIssueMixingDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueMixingDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield GoodsIssueMixingDetailState.failure(
                errorMessage:
                    '${qrResult} tidak di temukan di gudang dan WO ${woNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.woId == 0) {
                yield GoodsIssueMixingDetailState.failure(
                  errorMessage:
                      '${qrResult} tidak di temukan di gudang dan WO ${woNo} (2)',
                  data: event.data,
                );
              } else {
                yield GoodsIssueMixingDetailState.success(
                  data: newData,
                  // newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield GoodsIssueMixingDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueMixingDetailEventRefresh) {
      var woId = event.woId;
      var newData = currentState.data;
      var listData = currentState.data.items;

      if (woId == 0) {
        yield GoodsIssueMixingDetailState.success(
          data: Data(items: List<goodsIssueDetail.Item>()),
        );
      } else {
        yield GoodsIssueMixingDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueMixingDetailResponse response =
              await _repository.goodsIssueMixingDetail_ViewDetailItem(woId);
          if (response == null) {
            yield GoodsIssueMixingDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueMixingDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueMixingDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueMixingDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsIssueMixingDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield GoodsIssueMixingDetailState.success(
        data: newData,
      );
    } else if (event is GoodsIssueMixingDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield GoodsIssueMixingDetailState.success(
        data: newData,
      );
    } else if (event is GoodsIssueMixingDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield GoodsIssueMixingDetailState.success(
        data: newData,
      );
    } else if (event is GoodsIssueMixingDetailEventAdd) {
      yield GoodsIssueMixingDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueMixingDetailResponse response =
            await _repository.goodsIssueMixingDetail_Add(event.data);
        if (response == null) {
          yield GoodsIssueMixingDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueMixingDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield GoodsIssueMixingDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ?? Data(items: List<goodsIssueDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield GoodsIssueMixingDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueMixingDetailEventCancel) {
      yield GoodsIssueMixingDetailState.busy(
        data: currentState.data,
      );

      yield GoodsIssueMixingDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
