import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsReceiptDetailItemDetailState extends BlocState {
  GoodsReceiptDetailItemDetailState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.errorMessage: '',
  });

  final Item data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  factory GoodsReceiptDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return GoodsReceiptDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory GoodsReceiptDetailItemDetailState.busy({
    @required Item data,
  }) {
    return GoodsReceiptDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory GoodsReceiptDetailItemDetailState.success({
    @required Item data,
    Data newData,
    String errorMessage,
  }) {
    return GoodsReceiptDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory GoodsReceiptDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return GoodsReceiptDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
