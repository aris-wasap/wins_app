// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_receipt_production_label_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflReceiptProductionLabelResponse _$CflReceiptProductionLabelResponseFromJson(
    Map<String, dynamic> json) {
  return CflReceiptProductionLabelResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflReceiptProductionLabelResponseToJson(
        CflReceiptProductionLabelResponse instance) =>
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
    docEntry: json['DocEntry'] as int,
    docNum: json['DocNum'] as String,
    docDate: json['DocDate'] == null
        ? null
        : DateTime.parse(json['DocDate'] as String),
    woId: json['WoId'] as int,
    woNo: json['WoNo'] as String,
    status: json['Status'] as String,
    productCode: json['ProductCode'] as String,
    productName: json['ProductName'] as String,
    seriesName: json['SeriesName'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'DocEntry': instance.docEntry,
      'DocNum': instance.docNum,
      'DocDate': instance.docDate?.toIso8601String(),
      'WoId': instance.woId,
      'WoNo': instance.woNo,
      'ProductCode': instance.productCode,
      'ProductName': instance.productName,
      'SeriesName': instance.seriesName,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
    };
