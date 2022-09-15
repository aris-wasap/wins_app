// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_issue_mixing_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsIssueMixingListResponse _$GoodsIssueMixingListResponseFromJson(
    Map<String, dynamic> json) {
  return GoodsIssueMixingListResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsIssueMixingListResponseToJson(
        GoodsIssueMixingListResponse instance) =>
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
    createdUser: json['CreatedUser'] as String,
    seriesName: json['SeriesName'] as String,
    woNo: json['WoNo'] as String,
    seriesNameWo: json['SeriesNameWo'] as String,
    productCode: json['ProductCode'] as String,
    productName: json['ProductName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'CreatedUser': instance.createdUser,
      'SeriesName': instance.seriesName,
      'WoNo': instance.woNo,
      'SeriesNameWo': instance.seriesNameWo,
      'ProductCode': instance.productCode,
      'ProductName': instance.productName,
    };
