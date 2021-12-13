import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/models/transfer_release_detail_response.dart';
import 'package:meta/meta.dart';

class TransferReleaseDetailEvent extends BlocEvent {
  TransferReleaseDetailEvent({
    this.id,
    this.data,
    this.item,
    this.whsCodeFrom,
    this.itemIndex,
    this.qrResult,
  });

  final int id;
  final Data data;
  final Item item;
  final String whsCodeFrom;
  final int itemIndex;
  final String qrResult;
}

class TransferReleaseDetailEventNormal extends TransferReleaseDetailEvent {
  TransferReleaseDetailEventNormal() : super();
}

class TransferReleaseDetailEventGetId extends TransferReleaseDetailEvent {
  TransferReleaseDetailEventGetId({
    @required int id,
  }) : super(
          id: id,
        );
}

class TransferReleaseDetailEventScan extends TransferReleaseDetailEvent {
  TransferReleaseDetailEventScan({
    @required Data data,
    @required String whsCodeFrom,
    @required String qrResult,
  }) : super(
          data: data,
          whsCodeFrom: whsCodeFrom,
          qrResult: qrResult,
        );
}

class TransferReleaseDetailEventItemAdd extends TransferReleaseDetailEvent {
  TransferReleaseDetailEventItemAdd({
    @required Item item,
  }) : super(
          item: item,
        );
}

class TransferReleaseDetailEventItemUpdate extends TransferReleaseDetailEvent {
  TransferReleaseDetailEventItemUpdate({
    @required Item item,
    @required int itemIndex,
  }) : super(
          item: item,
          itemIndex: itemIndex,
        );
}

class TransferReleaseDetailEventItemRemove extends TransferReleaseDetailEvent {
  TransferReleaseDetailEventItemRemove({
    @required int itemIndex,
  }) : super(
          itemIndex: itemIndex,
        );
}

class TransferReleaseDetailEventAdd extends TransferReleaseDetailEvent {
  TransferReleaseDetailEventAdd({
    @required Data data,
  }) : super(
          data: data,
        );
}

class TransferReleaseDetailEventCancel extends TransferReleaseDetailEvent {
  TransferReleaseDetailEventCancel({
    @required int id,
  }) : super(
          id: id,
        );
}
