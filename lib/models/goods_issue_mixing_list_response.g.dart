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
    recordNo: json['RecordNo'] as int,
    id: json['Id'] as int,
    userId: json['UserId'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    woStatus: json['WoStatus'] as String,
    status: json['Status'] as String,
    createdUser: json['CreatedUser'] as String,
    seriesName: json['SeriesName'] as String,
    woNo: json['WoNo'] as String,
    seriesNameWo: json['SeriesNameWo'] as String,
    productCode: json['ProductCode'] as String,
    productName: json['ProductName'] as String,
    plannedQty: (json['PlannedQty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    productionType: json['ProductionType'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'RecordNo': instance.recordNo,
      'Id': instance.id,
      'UserId': instance.userId,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'WoStatus': instance.woStatus,
      'Status': instance.status,
      'CreatedUser': instance.createdUser,
      'SeriesName': instance.seriesName,
      'WoNo': instance.woNo,
      'SeriesNameWo': instance.seriesNameWo,
      'ProductCode': instance.productCode,
      'ProductName': instance.productName,
      'PlannedQty': instance.plannedQty,
      'Uom': instance.uom,
      'ProductionType': instance.productionType,
    };
