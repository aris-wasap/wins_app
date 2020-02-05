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
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    status: json['Status'] as String,
    whsCodeFrom: json['WhsCodeFrom'] as String,
    whsCodeTo: json['WhsCodeTo'] as String,
    createdUser: json['CreatedUser'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'WhsCodeFrom': instance.whsCodeFrom,
      'WhsCodeTo': instance.whsCodeTo,
      'CreatedUser': instance.createdUser,
    };
