import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueMixingDetailState extends BlocState {
  GoodsIssueMixingDetailState({
    @required this.data,
    this.newItem,
    this.listItem,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.succesMessage: '',
    this.errorMessage: '',
  });

  final Data data;
  final Item newItem;
  final List<Item> listItem;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String succesMessage;
  final String errorMessage;

  factory GoodsIssueMixingDetailState.noAction() {
    return GoodsIssueMixingDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory GoodsIssueMixingDetailState.busy({
    @required Data data,
    Item newItem,
    List<Item> listItem,
  }) {
    return GoodsIssueMixingDetailState(
        data: data, isBusy: true, listItem: listItem);
  }

  factory GoodsIssueMixingDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
    List<Item> listItem,
  }) {
    return GoodsIssueMixingDetailState(
        isSuccess: true,
        succesMessage: succesMessage,
        data: data,
        newItem: newItem,
        listItem: listItem);
  }

  factory GoodsIssueMixingDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return GoodsIssueMixingDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
