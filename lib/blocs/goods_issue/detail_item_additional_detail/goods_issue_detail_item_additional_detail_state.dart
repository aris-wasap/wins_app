import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailItemAdditionalDetailState extends BlocState {
  GoodsIssueDetailItemAdditionalDetailState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.errorMessage: '',
    this.newData,
  });

  final Item data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final Data newData;

  factory GoodsIssueDetailItemAdditionalDetailState.noAction({
    @required Item data,
  }) {
    return GoodsIssueDetailItemAdditionalDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory GoodsIssueDetailItemAdditionalDetailState.busy({
    @required Item data,
  }) {
    return GoodsIssueDetailItemAdditionalDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory GoodsIssueDetailItemAdditionalDetailState.success({
    Item data,
    Data newData,
    String errorMessage,
  }) {
    return GoodsIssueDetailItemAdditionalDetailState(
      isSuccess: true,
      isBusy: false,
      data: data,
      newData: newData,
    );
  }

  factory GoodsIssueDetailItemAdditionalDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return GoodsIssueDetailItemAdditionalDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
