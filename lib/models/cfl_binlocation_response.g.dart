// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_binlocation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflBinLocationResponse _$CflBinLocationResponseFromJson(
    Map<String, dynamic> json) {
  return CflBinLocationResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflBinLocationResponseToJson(
        CflBinLocationResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    absEntry: json['AbsEntry'] as int,
    binCode: json['BinCode'] as String,
    whsCode: json['WhsCode'] as String,
    sysBin: json['SysBin'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'AbsEntry': instance.absEntry,
      'BinCode': instance.binCode,
      'WhsCode': instance.whsCode,
      'SysBin': instance.sysBin,
    };
