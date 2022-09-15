// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_scale_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflScaleResponse _$CflScaleResponseFromJson(Map<String, dynamic> json) {
  return CflScaleResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflScaleResponseToJson(CflScaleResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    code: json['Code'] as String,
    name: json['Name'] as String,
    noPo: json['NoPo'] as String,
    noKendaraan: json['NoKendaraan'] as String,
    namaBarang: json['NamaBarang'] as String,
    vendor: json['Vendor'] as String,
    jnsMobil: json['JnsMobil'] as String,
    beratMasuk: json['BeratMasuk'] as String,
    beratKeluar: json['BeratKeluar'] as String,
    beratNetto: json['BeratNetto'] as String,
    sopir: json['Sopir'] as String,
    tglMasuk: json['TglMasuk'] == null
        ? null
        : DateTime.parse(json['TglMasuk'] as String),
    tglKeluar: json['TglKeluar'] == null
        ? null
        : DateTime.parse(json['TglKeluar'] as String),
    jamKeluar: json['JamKeluar'] as String,
    jamMasuk: json['JamMasuk'] as String,
    operatorMasuk: json['OperatorMasuk'] as String,
    operatorKeluar: json['OperatorKeluar'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Code': instance.code,
      'Name': instance.name,
      'NoPo': instance.noPo,
      'NoKendaraan': instance.noKendaraan,
      'NamaBarang': instance.namaBarang,
      'Vendor': instance.vendor,
      'JnsMobil': instance.jnsMobil,
      'BeratMasuk': instance.beratMasuk,
      'BeratKeluar': instance.beratKeluar,
      'BeratNetto': instance.beratNetto,
      'Sopir': instance.sopir,
      'TglMasuk': instance.tglMasuk?.toIso8601String(),
      'JamMasuk': instance.jamMasuk,
      'TglKeluar': instance.tglKeluar?.toIso8601String(),
      'JamKeluar': instance.jamKeluar,
      'OperatorMasuk': instance.operatorMasuk,
      'OperatorKeluar': instance.operatorKeluar,
    };
