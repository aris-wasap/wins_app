// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_transfer_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryTransferDetailResponse _$InventoryTransferDetailResponseFromJson(
    Map<String, dynamic> json) {
  return InventoryTransferDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InventoryTransferDetailResponseToJson(
        InventoryTransferDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['Id'] as int,
    userId: json['UserId'] as int,
    transNo: json['TransNo'] as String,
    seriesName: json['SeriesName'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    fromWhsCode: json['FromWhsCode'] as String,
    fromWhsName: json['FromWhsName'] as String,
    fromAbsEntry: json['FromAbsEntry'] as int,
    fromBinCode: json['FromBinCode'] as String,
    toWhsCode: json['ToWhsCode'] as String,
    toWhsName: json['ToWhsName'] as String,
    toAbsEntry: json['ToAbsEntry'] as int,
    toBinCode: json['ToBinCode'] as String,
    totalQty: (json['TotalQty'] as num)?.toDouble(),
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'TransNo': instance.transNo,
      'SeriesName': instance.seriesName,
      'TransDate': instance.transDate?.toIso8601String(),
      'FromWhsCode': instance.fromWhsCode,
      'FromWhsName': instance.fromWhsName,
      'FromAbsEntry': instance.fromAbsEntry,
      'FromBinCode': instance.fromBinCode,
      'ToWhsCode': instance.toWhsCode,
      'ToWhsName': instance.toWhsName,
      'ToAbsEntry': instance.toAbsEntry,
      'ToBinCode': instance.toBinCode,
      'TotalQty': instance.totalQty,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    availableQty: (json['AvailableQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    toWhsCode: json['ToWhsCode'] as String,
    toAbsEntry: json['ToAbsEntry'] as int,
    toBinCode: json['ToBinCode'] as String,
    batchNo: json['BatchNo'] as String,
  )
    ..fromWhsCode = json['FromWhsCode'] as String
    ..fromAbsEntry = json['FromAbsEntry'] as int
    ..fromBinCode = json['FromBinCode'] as String;
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'AvailableQty': instance.availableQty,
      'Qty': instance.qty,
      'Uom': instance.uom,
      'FromWhsCode': instance.fromWhsCode,
      'FromAbsEntry': instance.fromAbsEntry,
      'FromBinCode': instance.fromBinCode,
      'ToWhsCode': instance.toWhsCode,
      'ToAbsEntry': instance.toAbsEntry,
      'ToBinCode': instance.toBinCode,
      'BatchNo': instance.batchNo,
    };
