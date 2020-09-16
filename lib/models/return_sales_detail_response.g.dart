// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_sales_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnSalesDetailResponse _$ReturnSalesDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ReturnSalesDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReturnSalesDetailResponseToJson(
        ReturnSalesDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    returnRequestId: json['ReturnRequestId'] as int,
    returnRequestNo: json['ReturnRequestNo'] as String,
    seriesNameReqNo: json['SeriesNameReqNo'] as String,
    doId: json['DoId'] as int,
    doNo: json['DoNo'] as String,
    seriesNameDo: json['SeriesNameDo'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    seriesName: json['SeriesName'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    customerCode: json['CustomerCode'] as String,
    customerName: json['CustomerName'] as String,
    contactPerson: json['ContactPerson'] as String,
    refNo: json['RefNo'] as String,
    address: json['Address'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    sapReturnId: json['SapReturnId'] as int,
    createdUser: json['CreatedUser'] as int,
    status: json['Status'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'ReturnRequestId': instance.returnRequestId,
      'ReturnRequestNo': instance.returnRequestNo,
      'SeriesNameReqNo': instance.seriesNameReqNo,
      'Id': instance.id,
      'DoId': instance.doId,
      'DoNo': instance.doNo,
      'SeriesNameDo': instance.seriesNameDo,
      'TransNo': instance.transNo,
      'SeriesName': instance.seriesName,
      'TransDate': instance.transDate?.toIso8601String(),
      'CustomerCode': instance.customerCode,
      'CustomerName': instance.customerName,
      'ContactPerson': instance.contactPerson,
      'RefNo': instance.refNo,
      'Address': instance.address,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'SapReturnId': instance.sapReturnId,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    returnRequestId: json['ReturnRequestId'] as int,
    returnRequestLineNo: json['ReturnRequestLineNo'] as int,
    doId: json['DoId'] as int,
    doLineNo: json['DoLineNo'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    reqQty: (json['ReqQty'] as num)?.toDouble(),
    doQty: (json['DoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    batchNo: json['BatchNo'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'ReturnRequestId': instance.returnRequestId,
      'ReturnRequestLineNo': instance.returnRequestLineNo,
      'DoId': instance.doId,
      'DoLineNo': instance.doLineNo,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'ReqQty': instance.reqQty,
      'DoQty': instance.doQty,
      'Qty': instance.qty,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'BatchNo': instance.batchNo,
    };
