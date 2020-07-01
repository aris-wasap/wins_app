// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_production_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptProductionDetailResponse _$ReceiptProductionDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptProductionDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptProductionDetailResponseToJson(
        ReceiptProductionDetailResponse instance) =>
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
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['Id'] as int,
    woId: json['WoId'] as int,
    woNo: json['WoNo'] as String,
    webId: json['WebId'] as int,
    webDetId: json['WebDetId'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    quantity: (json['Quantity'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    batchNo: json['BatchNo'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'Id': instance.id,
      'WoId': instance.woId,
      'WoNo': instance.woNo,
      'WebId': instance.webId,
      'WebDetId': instance.webDetId,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'Quantity': instance.quantity,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'BatchNo': instance.batchNo,
    };
