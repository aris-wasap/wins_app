import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueMixingDetailItemDetailState extends BlocState {
  GoodsIssueMixingDetailItemDetailState({
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

  factory GoodsIssueMixingDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return GoodsIssueMixingDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory GoodsIssueMixingDetailItemDetailState.busy({
    @required Item data,
  }) {
    return GoodsIssueMixingDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory GoodsIssueMixingDetailItemDetailState.success({
    @required Item data,
  }) {
    return GoodsIssueMixingDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory GoodsIssueMixingDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return GoodsIssueMixingDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
