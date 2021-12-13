import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_branch_detail_response.dart';
import 'package:meta/meta.dart';

class ReceiptBranchDetailState extends BlocState {
  ReceiptBranchDetailState({
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

  factory ReceiptBranchDetailState.noAction() {
    return ReceiptBranchDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory ReceiptBranchDetailState.busy({
    @required Data data,
  }) {
    return ReceiptBranchDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReceiptBranchDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return ReceiptBranchDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory ReceiptBranchDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return ReceiptBranchDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
