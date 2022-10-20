import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueMixingDetailItemBatchDetailState extends BlocState {
  GoodsIssueMixingDetailItemBatchDetailState({
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

  factory GoodsIssueMixingDetailItemBatchDetailState.noAction({
    @required ItemBatch data,
  }) {
    return GoodsIssueMixingDetailItemBatchDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory GoodsIssueMixingDetailItemBatchDetailState.busy({
    @required ItemBatch data,
  }) {
    return GoodsIssueMixingDetailItemBatchDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory GoodsIssueMixingDetailItemBatchDetailState.success({
    @required ItemBatch data,
  }) {
    return GoodsIssueMixingDetailItemBatchDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory GoodsIssueMixingDetailItemBatchDetailState.failure({
    @required ItemBatch data,
    @required String errorMessage,
  }) {
    return GoodsIssueMixingDetailItemBatchDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
