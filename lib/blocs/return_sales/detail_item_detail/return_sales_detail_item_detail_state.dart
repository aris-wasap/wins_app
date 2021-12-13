import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/return_sales_detail_response.dart';
import 'package:meta/meta.dart';

class ReturnSalesDetailItemDetailState extends BlocState {
  ReturnSalesDetailItemDetailState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.errorMessage: '',
  });

  final Item data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  factory ReturnSalesDetailItemDetailState.noAction({
    @required Item data,
  }) {
    return ReturnSalesDetailItemDetailState(
      // data: Data(items: List<Item>()),
      data: data,
    );
  }

  factory ReturnSalesDetailItemDetailState.busy({
    @required Item data,
  }) {
    return ReturnSalesDetailItemDetailState(
      data: data,
      isBusy: true,
    );
  }

  factory ReturnSalesDetailItemDetailState.success({
    @required Item data,
  }) {
    return ReturnSalesDetailItemDetailState(
      isSuccess: true,
      data: data,
    );
  }

  factory ReturnSalesDetailItemDetailState.failure({
    @required Item data,
    @required String errorMessage,
  }) {
    return ReturnSalesDetailItemDetailState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
