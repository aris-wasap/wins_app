import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/cfl_db_warehouse/cfl_db_warehouse_event.dart';
import 'package:admart_app/blocs/cfl_db_warehouse/cfl_db_warehouse_state.dart';
import 'package:admart_app/models/cfl_db_warehouse_model.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CflDbWarehouseBloc
    extends BlocEventStateBase<CflDbWarehouseEvent, CflDbWarehouseState> {
  CflDbWarehouseBloc()
      : super(
          initialState: CflDbWarehouseState.noAction(),
        );

  final BehaviorSubject<String> _firstIdController =
      BehaviorSubject<String>(seedValue: "");
  final BehaviorSubject<String> _lastIdController =
      BehaviorSubject<String>(seedValue: "");

  @override
  void dispose() {
    _firstIdController.close();
    _lastIdController.close();

    super.dispose();
  }

  @override
  Stream<CflDbWarehouseState> eventHandler(
      CflDbWarehouseEvent event, CflDbWarehouseState currentState) async* {
    switch (event.event) {
      case CflDbWarehouseEventType.activedSearch:
        yield CflDbWarehouseState.success(
            data: currentState.data, isActiveSearch: true);

        break;
      case CflDbWarehouseEventType.deactivedSearch:
        {
          yield CflDbWarehouseState.busy(
              data: currentState.data, isActiveSearch: false);
          try {
            var _repository = Repository();
            List<CflDbWarehouseModel> data =
                await _repository.cflDbWarehouse_FetchNextPage("", "");
            if (data == null) {
              yield CflDbWarehouseState.failure(
                  errorMessage: 'DB Local null',
                  data: currentState.data,
                  isActiveSearch: false);
            } else {
              if (data.length == 0) {
                _firstIdController.value = "";
                _lastIdController.value = "";
              } else {
                _firstIdController.value = data[0].whsCode;
                _lastIdController.value = data[data.length - 1].whsCode;
              }

              yield CflDbWarehouseState.success(data: data, isActiveSearch: false);
            }
          } catch (e) {
            yield CflDbWarehouseState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: false);
          }
        }
        break;
      case CflDbWarehouseEventType.firstPage:
        {
          yield CflDbWarehouseState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            List<CflDbWarehouseModel> data = await _repository
                .cflDbWarehouse_FetchNextPage("", event.searchQuery);
            if (data == null) {
              yield CflDbWarehouseState.failure(
                  errorMessage: 'DB Local null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              if (data.length == 0) {
                _firstIdController.value = "";
                _lastIdController.value = "";
              } else {
                _firstIdController.value = data[0].whsCode;
                _lastIdController.value = data[data.length - 1].whsCode;
              }
              yield CflDbWarehouseState.success(
                  data: data, isActiveSearch: currentState.isActiveSearch);
            }
          } catch (e) {
            yield CflDbWarehouseState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case CflDbWarehouseEventType.nextPage:
        {
          yield CflDbWarehouseState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            List<CflDbWarehouseModel> data =
                await _repository.cflDbWarehouse_FetchNextPage(
                    _lastIdController.value, event.searchQuery);
            if (data == null) {
              yield CflDbWarehouseState.failure(
                  errorMessage: 'DB Local null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              if (data.length == 0) {
              } else {
                _lastIdController.value = data[data.length - 1].whsCode;
              }

              currentState.data.addAll(data);
              yield CflDbWarehouseState.success(
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            }
          } catch (e) {
            yield CflDbWarehouseState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      case CflDbWarehouseEventType.refresh:
        {
          yield CflDbWarehouseState.busy(
              data: currentState.data,
              isActiveSearch: currentState.isActiveSearch);
          try {
            var _repository = Repository();
            //List<CflDbWarehouseModel> data = await _repository.cflDbWarehouse_Refresh(_lastIdController.value, event.searchQuery);
            List<CflDbWarehouseModel> data = await _repository.cflDbWarehouse_Refresh("", event.searchQuery);
            if (data == null) {
              yield CflDbWarehouseState.failure(
                  errorMessage: 'DB Local null',
                  data: currentState.data,
                  isActiveSearch: currentState.isActiveSearch);
            } else {
              if (data.length == 0) {
                _firstIdController.value = "";
                _lastIdController.value = "";
              } else {
                _firstIdController.value = data[0].whsCode;
                _lastIdController.value = data[data.length - 1].whsCode;
              }
              yield CflDbWarehouseState.success(
                  data: data, isActiveSearch: currentState.isActiveSearch);
            }
          } catch (e) {
            yield CflDbWarehouseState.failure(
                errorMessage: "fail ${event.event}",
                data: currentState.data,
                isActiveSearch: currentState.isActiveSearch);
          }
        }
        break;
      default:
        {}
    }
  }
}
