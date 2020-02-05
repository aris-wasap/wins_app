import 'package:ncf_app/bloc_helpers/bloc_event_state.dart';

class DownloadEvent extends BlocEvent {
  DownloadEvent({
    this.event, 
  });

  final DownloadEventType event; 
}

enum DownloadEventType {
  none,
  normal,
  all, 
  warehouse, 
}
