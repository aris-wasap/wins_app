import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/receipt_branch_list_response.dart';
import 'package:meta/meta.dart';

class ReceiptBranchListState extends BlocState {
  ReceiptBranchListState({
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

  factory ReceiptBranchListState.noAction() {
    return ReceiptBranchListState(data: List<Data>());
  }

  factory ReceiptBranchListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptBranchListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptBranchListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReceiptBranchListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReceiptBranchListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return ReceiptBranchListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
