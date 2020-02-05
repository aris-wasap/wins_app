// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serverInfo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerInfoResponse _$ServerInfoResponseFromJson(Map<String, dynamic> json) {
  return ServerInfoResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ServerInfoResponseToJson(ServerInfoResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    serverDate: json['ServerDate'] == null
        ? null
        : DateTime.parse(json['ServerDate'] as String),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'ServerDate': instance.serverDate?.toIso8601String(),
    };
