// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_branch_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferBranchDetailResponse _$TransferBranchDetailResponseFromJson(
    Map<String, dynamic> json) {
  return TransferBranchDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferBranchDetailResponseToJson(
        TransferBranchDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    requestId: json['RequestId'] as int,
    requestNo: json['RequestNo'] as String,
    seriesNameReqNo: json['SeriesNameReqNo'] as String,
    id: json['Id'] as int,
    seriesName: json['SeriesName'] as String,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    toBranchId: json['ToBranchId'] as int,
    toBranchName: json['ToBranchName'] as String,
    sapTransferBranchId: json['SapTransferBranchId'] as int,
    sapTransferBranchNo: json['SapTransferBranchNo'] as String,
    createdUser: json['CreatedUser'] as int,
    status: json['Status'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'RequestId': instance.requestId,
      'RequestNo': instance.requestNo,
      'SeriesNameReqNo': instance.seriesNameReqNo,
      'Id': instance.id,
      'SeriesName': instance.seriesName,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'ToBranchId': instance.toBranchId,
      'ToBranchName': instance.toBranchName,
      'SapTransferBranchId': instance.sapTransferBranchId,
      'SapTransferBranchNo': instance.sapTransferBranchNo,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    requestId: json['RequestId'] as int,
    requestLineNo: json['RequestLineNo'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    reqQty: (json['ReqQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    availableQty: (json['AvailableQty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    toWhsCode: json['ToWhsCode'] as String,
    toWhsName: json['ToWhsName'] as String,
    toBinAbs: json['ToBinAbs'] as int,
    toBinCode: json['ToBinCode'] as String,
    batchNo: json['BatchNo'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'RequestId': instance.requestId,
      'RequestLineNo': instance.requestLineNo,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'ReqQty': instance.reqQty,
      'Qty': instance.qty,
      'AvailableQty': instance.availableQty,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'ToWhsCode': instance.toWhsCode,
      'ToWhsName': instance.toWhsName,
      'ToBinAbs': instance.toBinAbs,
      'ToBinCode': instance.toBinCode,
      'BatchNo': instance.batchNo,
    };
