import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_production_detail_response.dart';
import 'package:meta/meta.dart';

class TransferProductionDetailState extends BlocState {
  TransferProductionDetailState({
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

  factory TransferProductionDetailState.noAction() {
    return TransferProductionDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory TransferProductionDetailState.busy({
    @required Data data,
  }) {
    return TransferProductionDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory TransferProductionDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return TransferProductionDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory TransferProductionDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return TransferProductionDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
