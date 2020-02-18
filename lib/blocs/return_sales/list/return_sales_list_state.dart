import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/return_sales_list_response.dart'; 
import 'package:meta/meta.dart';

class ReturnSalesListState extends BlocState {
  ReturnSalesListState({
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

  factory ReturnSalesListState.noAction() {
    return ReturnSalesListState(data: List<Data>());
  }

  factory ReturnSalesListState.busy(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReturnSalesListState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReturnSalesListState.success(
      {@required List<Data> data, @required bool isActiveSearch}) {
    return ReturnSalesListState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory ReturnSalesListState.failure(
      {@required List<Data> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return ReturnSalesListState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
