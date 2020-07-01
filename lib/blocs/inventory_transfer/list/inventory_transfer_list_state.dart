import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/inventory_transfer_list_response.dart'; 
import 'package:meta/meta.dart';

class InventoryTransferListState extends BlocState {
  InventoryTransferListState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.isActiveSearch: false,
    this.errorMessage: '',
  });

  final List<Data> data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final bool isActiveSearch;
  final String errorMessage;

  factory InventoryTransferListState.noAction() {
    return InventoryTransferListState(data: List<Data>());
  }

  factory InventoryTransferListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return InventoryTransferListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory InventoryTransferListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return InventoryTransferListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory InventoryTransferListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return InventoryTransferListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
