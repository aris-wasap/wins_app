import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueDetailItemDetailState extends BlocState {
  GoodsIssueDetailItemDetailState({
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

  factory GoodsIssueDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return GoodsIssueDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory GoodsIssueDetailItemDetailState.busy({
    @required Item data,
  }) {
    return GoodsIssueDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory GoodsIssueDetailItemDetailState.success({
    @required Item data,
  }) {
    return GoodsIssueDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory GoodsIssueDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return GoodsIssueDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
