// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailScanResponse _$ItemDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return ItemDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ItemDetailScanResponseToJson(
        ItemDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    distNumber: json['DistNumber'] as String,
    totalStock: (json['TotalStock'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    length2: (json['Length2'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
    micron: (json['Micron'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    details: (json['Details'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'DistNumber': instance.distNumber,
      'TotalStock': instance.totalStock,
      'Length': instance.length,
      'Length2': instance.length2,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'ItemType': instance.itemType,
      'Uom': instance.uom,
      'Details': instance.details,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    inDate: json['InDate'] as String,
    mnfDate: json['MnfDate'] as String,
    expDate: json['ExpDate'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    stock: (json['Stock'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
    micron: (json['Micron'] as num)?.toDouble(),
    uom: json['Uom'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'InDate': instance.inDate,
      'MnfDate': instance.mnfDate,
      'ExpDate': instance.expDate,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'Stock': instance.stock,
      'Length': instance.length,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'ItemType': instance.itemType,
      'Uom': instance.uom,
    };
