import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'serverInfo_response.g.dart';

ServerInfoResponse serverInfoResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ServerInfoResponse.fromJson(jsonData);
}

@JsonSerializable()
class ServerInfoResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  ServerInfoResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ServerInfoResponse.fromJson(Map<String, dynamic> json) {
    return _$ServerInfoResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServerInfoResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'ServerDate')
  DateTime serverDate;
  Data({
    this.serverDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
