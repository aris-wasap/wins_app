import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/return_sales_detail_response.dart';
import 'package:meta/meta.dart';

class ReturnSalesDetailState extends BlocState {
  ReturnSalesDetailState({
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

  factory ReturnSalesDetailState.noAction() {
    return ReturnSalesDetailState(
      data: Data(items: List<Item>()),
    );
  }

  factory ReturnSalesDetailState.busy({
    @required Data data,
  }) {
    return ReturnSalesDetailState(
      data: data,
      isBusy: true,
    );
  }

 
  factory ReturnSalesDetailState.success({
    String succesMessage,
    @required Data data,
    Item newItem,
  }) {
    return ReturnSalesDetailState(
      isSuccess: true,
      succesMessage: succesMessage,
      data: data,
      newItem: newItem,
    );
  }

  factory ReturnSalesDetailState.failure({
    @required Data data,
    @required String errorMessage,
  }) {
    return ReturnSalesDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
