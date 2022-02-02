import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/goods_receipt/detail/goods_receipt_detail_event.dart';
import 'package:wins_app/blocs/goods_receipt/detail/goods_receipt_detail_state.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:wins_app/models/goods_receipt_detail_scan_response.dart';
import 'package:wins_app/resources/repository.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart'
    as goodsReceiptDetail;

class GoodsReceiptDetailBloc extends BlocEventStateBase<GoodsReceiptDetailEvent,
    GoodsReceiptDetailState> {
  GoodsReceiptDetailBloc()
      : super(
          initialState: GoodsReceiptDetailState.noAction(),
        );

  @override
  Stream<GoodsReceiptDetailState> eventHandler(GoodsReceiptDetailEvent event,
      GoodsReceiptDetailState currentState) async* {
    if (event is GoodsReceiptDetailEventNormal) {
      yield GoodsReceiptDetailState.success(
        data: currentState.data,
      );
    } else if (event is GoodsReceiptDetailEventGetId) {
      if (event.id == 0) {
        yield GoodsReceiptDetailState.success(
          data: Data(items: List<goodsReceiptDetail.Item>()),
        );
      } else {
        yield GoodsReceiptDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          GoodsReceiptDetailResponse response =
              await _repository.goodsReceiptDetail_GetById(event.id);
          if (response == null) {
            yield GoodsReceiptDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield GoodsReceiptDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield GoodsReceiptDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield GoodsReceiptDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is GoodsReceiptDetailEventScan) {
      var woId = event.woId;
      var woNo = event.woNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield GoodsReceiptDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        GoodsReceiptDetailScanResponse response =
            await _repository.goodsReceiptDetail_Scan(woId, qrResult);
        if (response == null) {
          yield GoodsReceiptDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsReceiptDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield GoodsReceiptDetailState.failure(
                errorMessage:
                    'Item Batch Number ${qrResult} tidak di temukan  WO ${woNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.woId == 0) {
                yield GoodsReceiptDetailState.failure(
                  errorMessage:
                      'Item Batch Number ${qrResult} tidak di temukan  WO ${woNo} (2)',
                  data: event.data,
                );
              } else {
                yield GoodsReceiptDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield GoodsReceiptDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsReceiptDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield GoodsReceiptDetailState.success(
        data: newData,
      );
    } else if (event is GoodsReceiptDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield GoodsReceiptDetailState.success(
        data: newData,
      );
    } else if (event is GoodsReceiptDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield GoodsReceiptDetailState.success(
        data: newData,
      );
    } else if (event is GoodsReceiptDetailEventAdd) {
      yield GoodsReceiptDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        GoodsReceiptDetailResponse response =
            await _repository.goodsReceiptDetail_Add(event.data);
        if (response == null) {
          yield GoodsReceiptDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsReceiptDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield GoodsReceiptDetailState.success(
              succesMessage: response.errorMessage,
              data:
                  response.data ?? Data(items: List<goodsReceiptDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield GoodsReceiptDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }
    else if (event is GoodsReceiptDetailEventUpdate) {
      yield GoodsReceiptDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        GoodsReceiptDetailResponse response =
            await _repository.goodsReceiptDetail_Update(event.data);
        if (response == null) {
          yield GoodsReceiptDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsReceiptDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield GoodsReceiptDetailState.success(
              succesMessage: response.errorMessage,
              data:
                  response.data ?? Data(items: List<goodsReceiptDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield GoodsReceiptDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }
    else if (event is GoodsReceiptDetailEventPost) {
      yield GoodsReceiptDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        GoodsReceiptDetailResponse response =
            await _repository.goodsReceiptDetail_Post(event.data);
        if (response == null) {
          yield GoodsReceiptDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield GoodsReceiptDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield GoodsReceiptDetailState.success(
              succesMessage: response.errorMessage,
              data:
                  response.data ?? Data(items: List<goodsReceiptDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield GoodsReceiptDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is GoodsReceiptDetailEventCancel) {
      yield GoodsReceiptDetailState.busy(
        data: currentState.data,
      );

      yield GoodsReceiptDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
