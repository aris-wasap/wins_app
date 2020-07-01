import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/goods_receipt_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsReceiptDetailState extends BlocState {
  GoodsReceiptDetailState({
    @required this.data,
    this.newItem,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.succesMessage: '',
    this.errorMessage: '',
  });

  final Data data;
  final Item newItem;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String succesMessage;
  final String errorMessage;

  factory GoodsReceiptDetailState.noAction() {
    return GoodsReceiptDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory GoodsReceiptDetailState.busy({
    @required Data data,
  }) {
    return GoodsReceiptDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory GoodsReceiptDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return GoodsReceiptDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory GoodsReceiptDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return GoodsReceiptDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
