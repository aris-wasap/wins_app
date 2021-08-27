// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_returns_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseReturnsDetailResponse _$PurchaseReturnsDetailResponseFromJson(
    Map<String, dynamic> json) {
  return PurchaseReturnsDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PurchaseReturnsDetailResponseToJson(
        PurchaseReturnsDetailResponse instance) =>
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
    grpoId: json['GrpoId'] as int,
    grpoNo: json['GrpoNo'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    vendorCode: json['VendorCode'] as String,
    vendorName: json['VendorName'] as String,
    contactPerson: json['ContactPerson'] as String,
    refNo: json['RefNo'] as String,
    address: json['Address'] as String,
    seriesNameGrpo: json['SeriesNameGrpo'] as String,
    seriesName: json['SeriesName'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    sapReturnId: json['SapReturnId'] as int,
    sapReturnNo: json['SapReturnNo'] as String,
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
      'GrpoId': instance.grpoId,
      'GrpoNo': instance.grpoNo,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'VendorCode': instance.vendorCode,
      'VendorName': instance.vendorName,
      'ContactPerson': instance.contactPerson,
      'RefNo': instance.refNo,
      'Address': instance.address,
      'SeriesNameGrpo': instance.seriesNameGrpo,
      'SeriesName': instance.seriesName,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'SapReturnId': instance.sapReturnId,
      'SapReturnNo': instance.sapReturnNo,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    returnRequestId: json['ReturnRequestId'] as int,
    returnRequestLineNo: json['ReturnRequestLineNo'] as int,
    grpoId: json['GrpoId'] as int,
    grpoLineNo: json['GrpoLineNo'] as int,
    webId: json['WebId'] as int,
    webDetId: json['WebDetId'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    reqQty: (json['ReqQty'] as num)?.toDouble(),
    grpoQty: (json['GrpoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
    uom: json['Uom'] as String,
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
  )..length2 = (json['Length2'] as num)?.toDouble();
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'ReturnRequestId': instance.returnRequestId,
      'ReturnRequestLineNo': instance.returnRequestLineNo,
      'GrpoId': instance.grpoId,
      'GrpoLineNo': instance.grpoLineNo,
      'WebId': instance.webId,
      'WebDetId': instance.webDetId,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'ReqQty': instance.reqQty,
      'GrpoQty': instance.grpoQty,
      'Length': instance.length,
      'Length2': instance.length2,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'ManufacturingDate': instance.manufacturingDate?.toIso8601String(),
      'ExpirationDate': instance.expirationDate?.toIso8601String(),
      'ItemType': instance.itemType,
      'IsAsset': instance.isAsset,
      'IsBatch': instance.isBatch,
      'PriceMode': instance.priceMode,
      'Qty': instance.qty,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'BatchNo': instance.batchNo,
    };
