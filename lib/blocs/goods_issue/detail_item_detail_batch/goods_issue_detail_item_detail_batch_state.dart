import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailItemDetailBatchState extends BlocState {
  GoodsIssueDetailItemDetailBatchState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.errorMessage: '',
  });

  final ItemBatch data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  factory GoodsIssueDetailItemDetailBatchState.noAction({
    @required ItemBatch data,
  }) {
    return GoodsIssueDetailItemDetailBatchState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory GoodsIssueDetailItemDetailBatchState.busy({
    @required ItemBatch data,
  }) {
    return GoodsIssueDetailItemDetailBatchState(
      data: data,
      isBusy: true,
    );
  }

  factory GoodsIssueDetailItemDetailBatchState.success({
    @required ItemBatch data,
  }) {
    return GoodsIssueDetailItemDetailBatchState(
      isSuccess: true,
      data: data,
    );
  }

  factory GoodsIssueDetailItemDetailBatchState.failure({
    @required ItemBatch data,
    @required String errorMessage,
  }) {
    return GoodsIssueDetailItemDetailBatchState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
