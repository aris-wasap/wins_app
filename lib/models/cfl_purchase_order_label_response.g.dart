// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_purchase_order_label_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflPurchaseOrderLabelResponse _$CflPurchaseOrderLabelResponseFromJson(
    Map<String, dynamic> json) {
  return CflPurchaseOrderLabelResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflPurchaseOrderLabelResponseToJson(
        CflPurchaseOrderLabelResponse instance) =>
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
    status: json['Status'] as String,
    vendorCode: json['VendorCode'] as String,
    vendorName: json['VendorName'] as String,
    refNo: json['RefNo'] as String,
    scaleNo: json['ScaleNo'] as String,
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
      'VendorCode': instance.vendorCode,
      'VendorName': instance.vendorName,
      'RefNo': instance.refNo,
      'ScaleNo': instance.scaleNo,
      'SeriesName': instance.seriesName,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
    };
