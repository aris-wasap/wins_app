// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_item_batch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflItemBatchResponse _$CflItemBatchResponseFromJson(Map<String, dynamic> json) {
  return CflItemBatchResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflItemBatchResponseToJson(
        CflItemBatchResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    sysNumber: json['SysNumber'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    batchNumber: json['BatchNumber'] as String,
    absEntry: json['AbsEntry'] as int,
    binCode: json['BinCode'] as String,
    whsCode: json['WhsCode'] as String,
    plannedQty: (json['PlannedQty'] as num)?.toDouble(),
    availableQty: (json['AvailableQty'] as num)?.toDouble(),
    issueQty: (json['IssueQty'] as num)?.toDouble(),
    openQty: (json['OpenQty'] as num)?.toDouble(),
    location: json['Location'] as String,
  )..lineNum = json['LineNum'] as int;
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'SysNumber': instance.sysNumber,
      'LineNum': instance.lineNum,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'BatchNumber': instance.batchNumber,
      'AbsEntry': instance.absEntry,
      'BinCode': instance.binCode,
      'WhsCode': instance.whsCode,
      'PlannedQty': instance.plannedQty,
      'AvailableQty': instance.availableQty,
      'IssueQty': instance.issueQty,
      'OpenQty': instance.openQty,
      'Location': instance.location,
    };
