// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_production_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferProductionListResponse _$TransferProductionListResponseFromJson(
    Map<String, dynamic> json) {
  return TransferProductionListResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransferProductionListResponseToJson(
        TransferProductionListResponse instance) =>
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
    status: json['Status'] as String,
    fromWhsCode: json['FromWhsCode'] as String,
    fromWhsName: json['FromWhsName'] as String,
    toWhsCode: json['ToWhsCode'] as String,
    toWhsName: json['ToWhsName'] as String,
    createdUser: json['CreatedUser'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'TransNo': instance.transNo,
      'SeriesName': instance.seriesName,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'FromWhsCode': instance.fromWhsCode,
      'FromWhsName': instance.fromWhsName,
      'ToWhsCode': instance.toWhsCode,
      'ToWhsName': instance.toWhsName,
      'CreatedUser': instance.createdUser,
    };
