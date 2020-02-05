// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_reject_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRejectDetailResponse _$TransferRejectDetailResponseFromJson(
    Map<String, dynamic> json) {
  return TransferRejectDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferRejectDetailResponseToJson(
        TransferRejectDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    whsCodeFrom: json['WhsCodeFrom'] as String,
    whsNameFrom: json['WhsNameFrom'] as String,
    whsCodeTo: json['WhsCodeTo'] as String,
    whsNameTo: json['WhsNameTo'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'WhsCodeFrom': instance.whsCodeFrom,
      'WhsNameFrom': instance.whsNameFrom,
      'WhsCodeTo': instance.whsCodeTo,
      'WhsNameTo': instance.whsNameTo,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    qty: (json['Qty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    batchNo: json['BatchNo'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'Qty': instance.qty,
      'Uom': instance.uom,
      'BatchNo': instance.batchNo,
    };
