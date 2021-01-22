// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_purchase_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflPurchaseItemResponse _$CflPurchaseItemResponseFromJson(
    Map<String, dynamic> json) {
  return CflPurchaseItemResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflPurchaseItemResponseToJson(
        CflPurchaseItemResponse instance) =>
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
    status: json['Status'] as String,
    vendorCode: json['VendorCode'] as String,
    vendorName: json['VendorName'] as String,
    seriesName: json['SeriesName'] as String,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    unitPriceTc: (json['UnitPriceTc'] as num)?.toDouble(),
    quantity: (json['Quantity'] as num)?.toDouble(),
    lineNum: json['LineNum'] as int,
    lineStatus: json['LineStatus'] as String,
    isAsset: json['IsAsset'] as String,
    isBatch: json['IsBatch'] as String,
    uom: json['Uom'] as String,
    length: (json['Length'] as num)?.toDouble(),
    micron: (json['Micron'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'VendorCode': instance.vendorCode,
      'VendorName': instance.vendorName,
      'SeriesName': instance.seriesName,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'UnitPriceTc': instance.unitPriceTc,
      'Quantity': instance.quantity,
      'LineNum': instance.lineNum,
      'LineStatus': instance.lineStatus,
      'IsAsset': instance.isAsset,
      'IsBatch': instance.isBatch,
      'Length': instance.length,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'ItemType': instance.itemType,
    };
