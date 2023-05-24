import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/item_detail_scan_response.dart';
import 'package:meta/meta.dart';
import 'package:wins_app/models/item_detail_scan_serial_batch_number_response.dart';

class ItemDetailState extends BlocState {
  ItemDetailState({
    @required this.data,
    this.dataSnB,
    this.newItem,
    this.itemSnB,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.succesMessage: '',
    this.errorMessage: '',
  });

  final Data data;
  final DataSnB dataSnB;
  final Item newItem;
  final ItemSnB itemSnB;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String succesMessage;
  final String errorMessage;

  factory ItemDetailState.noAction() {
    return ItemDetailState(
      data: Data(details: List<Item>()),
    );
  }

  factory ItemDetailState.busy({
    Data data,
    DataSnB dataSnB,
  }) {
    return ItemDetailState(
      data: data,
      dataSnB: dataSnB,
      isBusy: true,
    );
  }

  factory ItemDetailState.success({
    String succesMessage,
    Data data,
    DataSnB dataSnB,
    Item newItem,
    ItemSnB itemSnB,
  }) {
    return ItemDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      dataSnB: dataSnB,
      newItem: newItem,
      itemSnB: itemSnB,
    );
  }

  factory ItemDetailState.failure({
    Data data,
    DataSnB dataSnB,
    @required String errorMessage,
  }) {
    return ItemDetailState(
      data: data,
      dataSnB: dataSnB,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
