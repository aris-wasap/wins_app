import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/transfer_branch_detail_response.dart';
import 'package:meta/meta.dart';

class TransferBranchDetailState extends BlocState {
  TransferBranchDetailState({
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

  factory TransferBranchDetailState.noAction() {
    return TransferBranchDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory TransferBranchDetailState.busy({
    @required Data data,
  }) {
    return TransferBranchDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory TransferBranchDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return TransferBranchDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory TransferBranchDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return TransferBranchDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
