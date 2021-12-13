import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/inventory_transfer_detail_response.dart';
import 'package:meta/meta.dart';

class InventoryTransferDetailState extends BlocState {
  InventoryTransferDetailState({
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

  factory InventoryTransferDetailState.noAction() {
    return InventoryTransferDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory InventoryTransferDetailState.busy({
    @required Data data,
  }) {
    return InventoryTransferDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory InventoryTransferDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return InventoryTransferDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory InventoryTransferDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return InventoryTransferDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
