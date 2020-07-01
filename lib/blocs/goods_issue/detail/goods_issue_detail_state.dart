import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailState extends BlocState {
  GoodsIssueDetailState({
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

  factory GoodsIssueDetailState.noAction() {
    return GoodsIssueDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory GoodsIssueDetailState.busy({
    @required Data data,
    Item newItem,
    List<Item> listItem,
  }) {
    return GoodsIssueDetailState(
      data: data,
      isBusy: true,
      listItem: listItem
    );
  }

 
  factory GoodsIssueDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
    List<Item> listItem,
  }) {
    return GoodsIssueDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
      listItem: listItem
    );
  }

  factory GoodsIssueDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return GoodsIssueDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
