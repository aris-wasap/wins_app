import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/inventory_transfer_detail_response.dart';
import 'package:meta/meta.dart';

class InventoryTransferDetailItemDetailState extends BlocState {
  InventoryTransferDetailItemDetailState({
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

  factory InventoryTransferDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return InventoryTransferDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory InventoryTransferDetailItemDetailState.busy({
    @required Item data,
  }) {
    return InventoryTransferDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory InventoryTransferDetailItemDetailState.success({
    @required Item data,
  }) {
    return InventoryTransferDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory InventoryTransferDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return InventoryTransferDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
