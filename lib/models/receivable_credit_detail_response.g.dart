// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receivable_credit_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivableCreditDetailResponse _$ReceivableCreditDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ReceivableCreditDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceivableCreditDetailResponseToJson(
        ReceivableCreditDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    returnRequestId: json['ReturnRequestId'] as int,
    returnRequestNo: json['ReturnRequestNo'] as String,
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
    sapReceivableCreditId: json['SapReceivableCreditId'] as int,
    sapReceivableCreditNo: json['SapReceivableCreditNo'] as String,
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
      'ReturnRequestId': instance.returnRequestId,
      'ReturnRequestNo': instance.returnRequestNo,
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
      'SapReceivableCreditId': instance.sapReceivableCreditId,
      'SapReceivableCreditNo': instance.sapReceivableCreditNo,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    returnRequestId: json['ReturnRequestId'] as int,
    returnRequestLineNo: json['ReturnRequestLineNo'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    reqQty: (json['ReqQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    length2: (json['Length2'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    type: json['Type'] as String,
    itemType: json['ItemType'] as String,
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    batchNo: json['BatchNo'] as String,
  )..micron = (json['Micron'] as num)?.toDouble();
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'ReturnRequestId': instance.returnRequestId,
      'ReturnRequestLineNo': instance.returnRequestLineNo,
      'Id': instance.id,
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
      'Type': instance.type,
      'ItemType': instance.itemType,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'BatchNo': instance.batchNo,
    };
