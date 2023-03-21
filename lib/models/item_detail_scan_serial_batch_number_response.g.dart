// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_scan_serial_batch_number_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailScanSerialBatchNumberResponse
    _$ItemDetailScanSerialBatchNumberResponseFromJson(
        Map<String, dynamic> json) {
  return ItemDetailScanSerialBatchNumberResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : DataSnB.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ItemDetailScanSerialBatchNumberResponseToJson(
        ItemDetailScanSerialBatchNumberResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

DataSnB _$DataSnBFromJson(Map<String, dynamic> json) {
  return DataSnB(
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    distNumber: json['DistNumber'] as String,
    inDate: json['InDate'] as String,
    mnfDate: json['MnfDate'] as String,
    expDate: json['ExpDate'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    totalStock: (json['TotalStock'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    length2: (json['Length2'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
    micron: (json['Micron'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    details: (json['Details'] as List)
        ?.map((e) =>
            e == null ? null : ItemSnB.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataSnBToJson(DataSnB instance) => <String, dynamic>{
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'DistNumber': instance.distNumber,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'InDate': instance.inDate,
      'MnfDate': instance.mnfDate,
      'ExpDate': instance.expDate,
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

ItemSnB _$ItemSnBFromJson(Map<String, dynamic> json) {
  return ItemSnB(
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    stock: (json['Stock'] as num)?.toDouble(),
    uom: json['Uom'] as String,
  );
}

Map<String, dynamic> _$ItemSnBToJson(ItemSnB instance) => <String, dynamic>{
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'Stock': instance.stock,
      'Uom': instance.uom,
    };
