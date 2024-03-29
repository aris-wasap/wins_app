// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_supplier_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptSupplierListResponse _$ReceiptSupplierListResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptSupplierListResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReceiptSupplierListResponseToJson(
        ReceiptSupplierListResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['Id'] as int,
    userId: json['UserId'] as int,
    sapReceiptSupplierNo: json['SapReceiptSupplierNo'] as String,
    poNo: json['PoNo'] as String,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    vendorCode: json['VendorCode'] as String,
    vendorName: json['VendorName'] as String,
    status: json['Status'] as String,
    createdUser: json['CreatedUser'] as String,
    seriesName: json['SeriesName'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'SapReceiptSupplierNo': instance.sapReceiptSupplierNo,
      'PoNo': instance.poNo,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'VendorCode': instance.vendorCode,
      'VendorName': instance.vendorName,
      'Status': instance.status,
      'CreatedUser': instance.createdUser,
      'SeriesName': instance.seriesName,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
    };
