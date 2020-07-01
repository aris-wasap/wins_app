import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/models/goods_issue_list_response.dart'; 
import 'package:meta/meta.dart';

class GoodsIssueListState extends BlocState {
  GoodsIssueListState({
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

  factory GoodsIssueListState.noAction() {
    return GoodsIssueListState(data: List<Data>());
  }

  factory GoodsIssueListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsIssueListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsIssueListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsIssueListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsIssueListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return GoodsIssueListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
