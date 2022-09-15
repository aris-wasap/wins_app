// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_purchase_reference_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflPurchaseReferenceResponse _$CflPurchaseReferenceResponseFromJson(
    Map<String, dynamic> json) {
  return CflPurchaseReferenceResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflPurchaseReferenceResponseToJson(
        CflPurchaseReferenceResponse instance) =>
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
      'VendorCode': instance.vendorCode,
      'VendorName': instance.vendorName,
      'RefNo': instance.refNo,
      'ScaleNo': instance.scaleNo,
      'SeriesName': instance.seriesName,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
    };
