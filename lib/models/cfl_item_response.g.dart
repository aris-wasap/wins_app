// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflItemResponse _$CflItemResponseFromJson(Map<String, dynamic> json) {
  return CflItemResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflItemResponseToJson(CflItemResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
    };
