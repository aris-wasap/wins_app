// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_issue_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestIssueDetailResponse _$RequestIssueDetailResponseFromJson(
    Map<String, dynamic> json) {
  return RequestIssueDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RequestIssueDetailResponseToJson(
        RequestIssueDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    requestId: json['RequestId'] as int,
    requestNo: json['RequestNo'] as String,
    seriesName: json['SeriesName'] as String,
    seriesNameReqNo: json['SeriesNameReqNo'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    sapRequestIssueId: json['SapRequestIssueId'] as int,
    sapRequestIssueNo: json['SapRequestIssueNo'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    createdUser: json['CreatedUser'] as int,
    status: json['Status'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'RequestId': instance.requestId,
      'RequestNo': instance.requestNo,
      'SeriesName': instance.seriesName,
      'SeriesNameReqNo': instance.seriesNameReqNo,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'SapRequestIssueId': instance.sapRequestIssueId,
      'SapRequestIssueNo': instance.sapRequestIssueNo,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    requestId: json['RequestId'] as int,
    requestLineNo: json['RequestLineNo'] as int,
    webId: json['WebId'] as int,
    webDetId: json['WebDetId'] as int,
    id: json['Id'] as int,
    detId: json['DetId'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    reqQty: (json['ReqQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    itemCost: (json['ItemCost'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    length: (json['Length'] as num)?.toDouble(),
    length2: (json['Length2'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
    type: json['Type'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    isAsset: json['IsAsset'] as String,
    isBatch: json['IsBatch'] as String,
    priceMode: json['PriceMode'] as String,
    batchNo: json['BatchNo'] as String,
    micron: (json['Micron'] as num)?.toDouble(),
    manufacturingDate: json['ManufacturingDate'] == null
        ? null
        : DateTime.parse(json['ManufacturingDate'] as String),
    expirationDate: json['ExpirationDate'] == null
        ? null
        : DateTime.parse(json['ExpirationDate'] as String),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'RequestId': instance.requestId,
      'RequestLineNo': instance.requestLineNo,
      'WebId': instance.webId,
      'WebDetId': instance.webDetId,
      'Id': instance.id,
      'DetId': instance.detId,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'ReqQty': instance.reqQty,
      'Qty': instance.qty,
      'Length': instance.length,
      'Length2': instance.length2,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'ItemType': instance.itemType,
      'Type': instance.type,
      'ManufacturingDate': instance.manufacturingDate?.toIso8601String(),
      'ExpirationDate': instance.expirationDate?.toIso8601String(),
      'ItemCost': instance.itemCost,
      'IsAsset': instance.isAsset,
      'IsBatch': instance.isBatch,
      'PriceMode': instance.priceMode,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'BatchNo': instance.batchNo,
    };
