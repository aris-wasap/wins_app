import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class DownloadState extends BlocState {
  DownloadState({
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.errorMessage: '',
    this.successMessage: '',
  });

  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final String successMessage;

  factory DownloadState.noAction() {
    return DownloadState();
  }

  factory DownloadState.busy() {
    return DownloadState(
      isBusy: true,
    );
  }

  factory DownloadState.success({String successMessage}) {
    return DownloadState(
      isSuccess: true,
      successMessage: successMessage,
    );
  }

  factory DownloadState.failure({
    @required String errorMessage,
  }) {
    return DownloadState(
      isFailure: true,
      errorMessage: errorMessage,
    );
  }
}
