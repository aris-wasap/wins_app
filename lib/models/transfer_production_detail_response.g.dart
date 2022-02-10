// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_production_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferProductionDetailResponse _$TransferProductionDetailResponseFromJson(
    Map<String, dynamic> json) {
  return TransferProductionDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferProductionDetailResponseToJson(
        TransferProductionDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    woId: json['WoId'] as int,
    woNo: json['WoNo'] as String,
    woDate: json['WoDate'] == null
        ? null
        : DateTime.parse(json['WoDate'] as String),
    productCode: json['ProductCode'] as String,
    productName: json['ProductName'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
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
    sapTransferProductionId: json['SapTransferProductionId'] as int,
    sapTransferProductionNo: json['SapTransferProductionNo'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'WoId': instance.woId,
      'WoNo': instance.woNo,
      'WoDate': instance.woDate?.toIso8601String(),
      'ProductCode': instance.productCode,
      'ProductName': instance.productName,
      'Id': instance.id,
      'TransNo': instance.transNo,
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
      'SapTransferProductionId': instance.sapTransferProductionId,
      'SapTransferProductionNo': instance.sapTransferProductionNo,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    woId: json['WoId'] as int,
    woLineNo: json['WoLineNo'] as int,
    woVisOrder: json['WoVisOrder'] as int,
    id: json['Id'] as int,
    detId: json['DetId'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    availableQty: (json['AvailableQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    openQty: (json['OpenQty'] as num)?.toDouble(),
    issueQty: (json['IssueQty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    fromWhsCode: json['FromWhsCode'] as String,
    fromWhsName: json['FromWhsName'] as String,
    fromAbsEntry: json['FromAbsEntry'] as int,
    fromBinCode: json['FromBinCode'] as String,
    toWhsCode: json['ToWhsCode'] as String,
    toWhsName: json['ToWhsName'] as String,
    toAbsEntry: json['ToAbsEntry'] as int,
    toBinCode: json['ToBinCode'] as String,
    batchNo: json['BatchNo'] as String,
    width: (json['Width'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    length2: (json['Length2'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    micron: (json['Micron'] as num)?.toDouble(),
    expirationDate: json['ExpirationDate'] == null
        ? null
        : DateTime.parse(json['ExpirationDate'] as String),
    manufacturingDate: json['ManufacturingDate'] == null
        ? null
        : DateTime.parse(json['ManufacturingDate'] as String),
    itemType: json['ItemType'] as String,
    type: json['Type'] as String,
    group: json['Group'] as String,
    machine: json['Machine'] as String,
    shift: json['Shift'] as String,
  )..plannedQty = (json['PlannedQty'] as num)?.toDouble();
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'WoId': instance.woId,
      'WoLineNo': instance.woLineNo,
      'WoVisOrder': instance.woVisOrder,
      'Id': instance.id,
      'DetId': instance.detId,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'PlannedQty': instance.plannedQty,
      'AvailableQty': instance.availableQty,
      'Qty': instance.qty,
      'OpenQty': instance.openQty,
      'IssueQty': instance.issueQty,
      'Uom': instance.uom,
      'FromWhsCode': instance.fromWhsCode,
      'FromWhsName': instance.fromWhsName,
      'FromAbsEntry': instance.fromAbsEntry,
      'FromBinCode': instance.fromBinCode,
      'ToWhsCode': instance.toWhsCode,
      'ToWhsName': instance.toWhsName,
      'ToAbsEntry': instance.toAbsEntry,
      'ToBinCode': instance.toBinCode,
      'BatchNo': instance.batchNo,
      'Length': instance.length,
      'Length2': instance.length2,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'ManufacturingDate': instance.manufacturingDate?.toIso8601String(),
      'ExpirationDate': instance.expirationDate?.toIso8601String(),
      'ItemType': instance.itemType,
      'Type': instance.type,
      'Group': instance.group,
      'Machine': instance.machine,
      'Shift': instance.shift,
    };
