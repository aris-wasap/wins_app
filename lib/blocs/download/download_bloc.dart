import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';
import 'package:ncf_app/blocs/download/download_event.dart';
import 'package:ncf_app/blocs/download/download_state.dart'; 
import 'package:ncf_app/resources/db_provider.dart';
import 'package:ncf_app/resources/repository.dart';

class DownloadBloc extends BlocEventStateBase<DownloadEvent, DownloadState> {
  DownloadBloc()
      : super(
          initialState: DownloadState.noAction(),
        );

  @override
  Stream<DownloadState> eventHandler(
      DownloadEvent event, DownloadState currentState) async* {
    switch (event.event) {
      case DownloadEventType.normal:
        {
          yield DownloadState.noAction();
        }

        break;
      case DownloadEventType.all:
        {
          yield DownloadState.busy();

          try {
            await DbProvider.db.initDB();
            await Repository().all_CopyApiToDb();
            yield DownloadState.success(successMessage: "Done..."); 
          } catch (e) {
            yield DownloadState.failure(
              errorMessage: "fail ${event.toString()}",
            );
          }
        }

        break; 
      case DownloadEventType.warehouse:
        {
          yield DownloadState.busy();

          try {
            await DbProvider.db.initDB();
            await Repository().warehouse_CopyApiToDb();
            yield DownloadState.success(successMessage: "Done..."); 
          } catch (e) {
            yield DownloadState.failure(
              errorMessage: "fail ${event.toString()}",
            );
          }
        }
  
        break;

      default:
        {}
    }
  }
}
