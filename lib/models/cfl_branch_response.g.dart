// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_branch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflBranchResponse _$CflBranchResponseFromJson(Map<String, dynamic> json) {
  return CflBranchResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflBranchResponseToJson(CflBranchResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
    };
