import 'package:wins_app/bloc_helpers/bloc_event_state.dart';

class TransferBranchListEvent extends BlocEvent {
  TransferBranchListEvent({
    this.event,
    this.searchQuery,
  });

  final TransferBranchListEventType event;
  final String searchQuery;
}

enum TransferBranchListEventType {
  none,
  firstPage,
  nextPage,
  refresh,
  activedSearch,
  deactivedSearch,
}
