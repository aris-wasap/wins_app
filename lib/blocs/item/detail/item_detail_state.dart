import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/item_detail_scan_response.dart';
import 'package:meta/meta.dart';

class ItemDetailState extends BlocState {
  ItemDetailState({
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

  factory ItemDetailState.noAction() {
    return ItemDetailState(
      data: Data(details: List<Item>()),
    );
  }

  factory ItemDetailState.busy({
    @required Data data,
  }) {
    return ItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ItemDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return ItemDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory ItemDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return ItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
