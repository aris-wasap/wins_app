import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/models/cfl_db_warehouse_model.dart'; 
import 'package:meta/meta.dart';

class CflDbWarehouseState extends BlocState {
  CflDbWarehouseState({
    @required this.data,
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.isActiveSearch: false,
    this.errorMessage: '',
  });

  final List<CflDbWarehouseModel> data;
  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final bool isActiveSearch;
  final String errorMessage;

  factory CflDbWarehouseState.noAction() {
    return CflDbWarehouseState(data: List<CflDbWarehouseModel>());
  }

  factory CflDbWarehouseState.busy(
      {@required List<CflDbWarehouseModel> data, @required bool isActiveSearch}) {
    return CflDbWarehouseState(
      data: data,
      isBusy: true,
      isActiveSearch: isActiveSearch,
    );
  }

  factory CflDbWarehouseState.success(
      {@required List<CflDbWarehouseModel> data, @required bool isActiveSearch}) {
    return CflDbWarehouseState(
      isSuccess: true,
      data: data,
      isActiveSearch: isActiveSearch,
    );
  }

  factory CflDbWarehouseState.failure(
      {@required List<CflDbWarehouseModel> data,
      @required String errorMessage,
      @required bool isActiveSearch}) {
    return CflDbWarehouseState(
      data: data,
      isFailure: true,
      errorMessage: errorMessage,
      isActiveSearch: isActiveSearch,
    );
  }
}
