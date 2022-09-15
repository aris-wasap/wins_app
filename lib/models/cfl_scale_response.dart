// To parse this JSON data, do
//
//     final CflScaleResponse = CflScaleResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_scale_response.g.dart';

CflScaleResponse cflScaleResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflScaleResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflScaleResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflScaleResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflScaleResponse.fromJson(Map<String, dynamic> json) {
    return _$CflScaleResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflScaleResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Code')
  String code;

  @JsonKey(name: 'Name')
  String name;

  @JsonKey(name: 'NoPo')
  String noPo;

  @JsonKey(name: 'NoKendaraan')
  String noKendaraan;

  @JsonKey(name: 'NamaBarang')
  String namaBarang;

  @JsonKey(name: 'Vendor')
  String vendor;

  @JsonKey(name: 'JnsMobil')
  String jnsMobil;

  @JsonKey(name: 'BeratMasuk')
  String beratMasuk;

  @JsonKey(name: 'BeratKeluar')
  String beratKeluar;

  @JsonKey(name: 'BeratNetto')
  String beratNetto;

  @JsonKey(name: 'Sopir')
  String sopir;

  @JsonKey(name: 'TglMasuk')
  DateTime tglMasuk;

  @JsonKey(name: 'JamMasuk')
  String jamMasuk;

  @JsonKey(name: 'TglKeluar')
  DateTime tglKeluar;

  @JsonKey(name: 'JamKeluar')
  String jamKeluar;

  @JsonKey(name: 'OperatorMasuk')
  String operatorMasuk;

  @JsonKey(name: 'OperatorKeluar')
  String operatorKeluar;

  Data({
    this.code,
    this.name,
    this.noPo,
    this.noKendaraan,
    this.namaBarang,
    this.vendor,
    this.jnsMobil,
    this.beratMasuk,
    this.beratKeluar,
    this.beratNetto,
    this.sopir,
    this.tglMasuk,
    this.tglKeluar,
    this.jamKeluar,
    this.jamMasuk,
    this.operatorMasuk,
    this.operatorKeluar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
