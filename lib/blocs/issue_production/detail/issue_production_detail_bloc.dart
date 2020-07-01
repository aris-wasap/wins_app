import 'package:admart_app/bloc_helpers/bloc_event_state.dart';
import 'package:admart_app/blocs/issue_production/detail/issue_production_detail_event.dart';
import 'package:admart_app/blocs/issue_production/detail/issue_production_detail_state.dart';
import 'package:admart_app/models/issue_production_detail_response.dart';
import 'package:admart_app/models/issue_production_detail_scan_response.dart';
import 'package:admart_app/resources/repository.dart';
import 'package:admart_app/models/issue_production_detail_response.dart'
    as issueProductionDetail;

class IssueProductionDetailBloc extends BlocEventStateBase<
    IssueProductionDetailEvent, IssueProductionDetailState> {
  IssueProductionDetailBloc()
      : super(
          initialState: IssueProductionDetailState.noAction(),
        );

  @override
  Stream<IssueProductionDetailState> eventHandler(IssueProductionDetailEvent event,
      IssueProductionDetailState currentState) async* {
    if (event is IssueProductionDetailEventNormal) {
      yield IssueProductionDetailState.success(
        data: currentState.data,
      );
    } else if (event is IssueProductionDetailEventGetId) {
      if (event.id == 0) {
        yield IssueProductionDetailState.success(
          data: Data(items: List<issueProductionDetail.Item>()),
        );
      } else {
        yield IssueProductionDetailState.busy(
          data: currentState.data,
        );
        try {
          var _repository = Repository();
          IssueProductionDetailResponse response =
              await _repository.issueProductionDetail_GetById(event.id);
          if (response == null) {
            yield IssueProductionDetailState.failure(
              errorMessage: 'Response null',
              data: event.data,
            );
          } else {
            bool error = response.error;
            if (error) {
              yield IssueProductionDetailState.failure(
                errorMessage: 'Fetch fail ${response.errorMessage}',
                data: event.data,
              );
            } else {
              yield IssueProductionDetailState.success(
                data: response.data,
              );
            }
          }
        } catch (e) {
          yield IssueProductionDetailState.failure(
            errorMessage: "fail ${event.toString()}",
            data: event.data,
          );
        }
      }
    } else if (event is IssueProductionDetailEventScan) {
      var woId = event.woId;
      var woNo = event.woNo;
      var qrResult = event.qrResult;
      var newData = currentState.data;

      yield IssueProductionDetailState.busy(
        data: currentState.data,
      );
      try {
        var _repository = Repository();
        IssueProductionDetailScanResponse response =
            await _repository.issueProductionDetail_Scan(woId, qrResult);
        if (response == null) {
          yield IssueProductionDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield IssueProductionDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            if (response.data == null) {
              yield IssueProductionDetailState.failure(
                errorMessage: '${qrResult} tidak di temukan di gudang logistic dan WO ${woNo} (1)',
                data: event.data,
              );
            } else {
              if (response.data.woId == 0) {
                yield IssueProductionDetailState.failure(
                  errorMessage: '${qrResult} tidak di temukan di gudang logistic dan WO ${woNo} (2)',
                  data: event.data,
                );
              } else {
                yield IssueProductionDetailState.success(
                  data: newData,
                  newItem: response.data,
                );
              }
            }
          }
        }
      } catch (e) {
        yield IssueProductionDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    }  else if (event is IssueProductionDetailEventItemAdd) {
      var newData = currentState.data;
      newData.items.add(event.item);
      yield IssueProductionDetailState.success(
        data: newData,
      );
    } else if (event is IssueProductionDetailEventItemUpdate) {
      var newData = currentState.data;
      newData.items[event.itemIndex] = event.item;
      yield IssueProductionDetailState.success(
        data: newData,
      );
    } else if (event is IssueProductionDetailEventItemRemove) {
      var newData = currentState.data;
      newData.items.removeAt(event.itemIndex);
      yield IssueProductionDetailState.success(
        data: newData,
      );
    } else if (event is IssueProductionDetailEventAdd) {
      yield IssueProductionDetailState.busy(
        data: event.data,
      );
      try {
        var _repository = Repository();
        IssueProductionDetailResponse response =
            await _repository.issueProductionDetail_Add(event.data);
        if (response == null) {
          yield IssueProductionDetailState.failure(
            errorMessage: 'Response null',
            data: event.data,
          );
        } else {
          bool error = response.error;
          if (error) {
            yield IssueProductionDetailState.failure(
              errorMessage: 'Fetch fail ${response.errorMessage}',
              data: event.data,
            );
          } else {
            yield IssueProductionDetailState.success(
              succesMessage: response.errorMessage,
              data: response.data ??
                  Data(items: List<issueProductionDetail.Item>()),
            );
          }
        }
      } catch (e) {
        yield IssueProductionDetailState.failure(
          errorMessage: "fail ${event.toString()}",
          data: event.data,
        );
      }
    } else if (event is IssueProductionDetailEventCancel) {
      yield IssueProductionDetailState.busy(
        data: currentState.data,
      );

      yield IssueProductionDetailState.success(
        data: currentState.data,
      );
    } else {}
  }
}
