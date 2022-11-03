import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_issue/detail/goods_issue_detail_event.dart';
import 'package:wins_app/blocs/goods_issue/detail/goods_issue_detail_state.dart';
//import 'package:wins_app/models/goods_issue_detail_refresh_response.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:wins_app/models/goods_issue_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart'
    as goodsIssueDetail;

class GoodsIssueDetailBloc
    extends BlocEventStateBase<GoodsIssueDetailEvent, GoodsIssueDetailState> {
  GoodsIssueDetailBloc()
      : super(
          initialState: GoodsIssueDetailState.noAction(),
        );

  @override
  Stream<GoodsIssueDetailState> eventHandler(
      GoodsIssueDetailEvent event, GoodsIssueDetailState currentState) async* {
    if (event is GoodsIssueDetailEventNormal) {
      yield GoodsIssueDetailState.success(
        data: currentState.data,
      );
    } else if (event is GoodsIssueDetailEventGetId) {
      if (event.id == 0) {
        yield GoodsIssueDetailState.success(
          data: Data(items: List<goodsIssueDetail.Item>()),
        );
      } else {
        yield GoodsIssueDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueDetailResponse response =
              await _repository.goodsIssueDetail_GetById(event.id);
          if (response == null) {
            yield GoodsIssueDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsIssueDetailEventScan) {
      var woId = event.woId;
      var woNo = event.woNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield GoodsIssueDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailScanResponse response =
            await _repository.goodsIssueDetail_Scan(woId, qrResult);
        if (response == null) {
          yield GoodsIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield GoodsIssueDetailState.failure(
                errorMessage:
                    '${qrResult} tidak di temukan di gudang dan WO ${woNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.woId == 0) {
                yield GoodsIssueDetailState.failure(
                  errorMessage:
                      '${qrResult} tidak di temukan di gudang dan WO ${woNo} (2)',
                  data: event.data,
                );
              } else {
                yield GoodsIssueDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield GoodsIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueDetailEventRefresh) {
      var woId = event.woId;
      //var newData = currentState.data;
      //var listData = currentState.data.items;

      if (woId == 0) {
        yield GoodsIssueDetailState.success(
          data: Data(items: List<goodsIssueDetail.Item>()),
        );
      } else {
        yield GoodsIssueDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueDetailResponse response =
              await _repository.goodsIssueDetail_ViewDetailItem(woId);
          if (response == null) {
            yield GoodsIssueDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsIssueDetailEventRefreshAfter) {
      var id = event.id;
      var newData = currentState.data;
      var listData = currentState.data.items;

      if (id == 0) {
        yield GoodsIssueDetailState.success(
          data: Data(items: List<goodsIssueDetail.Item>()),
        );
      } else {
        yield GoodsIssueDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueDetailResponse response =
              await _repository.goodsIssueDetail_RefreshAfter(id);
          if (response == null) {
            yield GoodsIssueDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsIssueDetailEventResetData) {
      var id = event.id;
      var woId = event.woId;
      // var newData = currentState.data;
      // var listData = currentState.data.items;

      if (id == 0) {
        yield GoodsIssueDetailState.success(
          data: Data(items: List<goodsIssueDetail.Item>()),
        );
      } else {
        yield GoodsIssueDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueDetailResponse response =
              await _repository.goodsIssueDetail_ResetData(id, woId);
          if (response == null) {
            yield GoodsIssueDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsIssueDetailEventPost) {
      yield GoodsIssueDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailResponse response =
            await _repository.goodsIssueDetail_Post(event.data);
        if (response == null) {
          yield GoodsIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield GoodsIssueDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ?? Data(items: List<goodsIssueDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield GoodsIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueDetailEventCancel) {
      if (event.id == 0) {
        yield GoodsIssueDetailState.success(
          data: Data(items: List<goodsIssueDetail.Item>()),
        );
      } else {
        yield GoodsIssueDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsIssueDetailResponse response =
              await _repository.goodsIssueDetail_Cancel(event.data);
          if (response == null) {
            yield GoodsIssueDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsIssueDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsIssueDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsIssueDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsIssueDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield GoodsIssueDetailState.busy(
        data: currentState.data,
      );
    } else if (event is GoodsIssueDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield GoodsIssueDetailState.success(
        data: newData,
      );
     
    } else if (event is GoodsIssueDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield GoodsIssueDetailState.success(
        data: newData,
      );
    } else if (event is GoodsIssueDetailEventAdd) {
      yield GoodsIssueDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        GoodsIssueDetailResponse response =
            await _repository.goodsIssueDetail_Add(event.data);
        if (response == null) {
          yield GoodsIssueDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsIssueDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield GoodsIssueDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ?? Data(items: List<goodsIssueDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield GoodsIssueDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsIssueDetailEventCancel) {
      yield GoodsIssueDetailState.busy(
        data: currentState.data,
      );

      yield GoodsIssueDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
