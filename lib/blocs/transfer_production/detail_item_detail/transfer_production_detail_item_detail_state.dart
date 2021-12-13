import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_production_detail_response.dart';
import 'package:meta/meta.dart';

class TransferProductionDetailItemDetailState extends BlocState {
  TransferProductionDetailItemDetailState({
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

  factory TransferProductionDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return TransferProductionDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory TransferProductionDetailItemDetailState.busy({
    @required Item data,
  }) {
    return TransferProductionDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferProductionDetailItemDetailState.success({
    @required Item data,
  }) {
    return TransferProductionDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory TransferProductionDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return TransferProductionDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
