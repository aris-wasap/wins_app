import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/goods_issue_list_response.dart';
import 'package:meta/meta.dart';

class GoodsIssueWOListState extends BlocState {
  GoodsIssueWOListState({
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

  factory GoodsIssueWOListState.noAction() {
    return GoodsIssueWOListState(data: List<Data>());
  }

  factory GoodsIssueWOListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsIssueWOListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsIssueWOListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return GoodsIssueWOListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory GoodsIssueWOListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return GoodsIssueWOListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
