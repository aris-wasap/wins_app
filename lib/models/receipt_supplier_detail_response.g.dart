// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_supplier_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptSupplierDetailResponse _$ReceiptSupplierDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptSupplierDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptSupplierDetailResponseToJson(
        ReceiptSupplierDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    poId: json['PoId'] as int,
    poNo: json['PoNo'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    webId: json['WebId'] as int,
    webNo: json['WebNo'] as String,
    vendorCode: json['VendorCode'] as String,
    vendorName: json['VendorName'] as String,
    contactPerson: json['ContactPerson'] as String,
    refNo: json['RefNo'] as String,
    address: json['Address'] as String,
    seriesNamePo: json['SeriesNamePo'] as String,
    seriesName: json['SeriesName'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    sapReceiptSupplierId: json['SapReceiptSupplierId'] as int,
    sapReceiptSupplierNo: json['SapReceiptSupplierNo'] as String,
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
      'PoId': instance.poId,
      'PoNo': instance.poNo,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'WebId': instance.webId,
      'WebNo': instance.webNo,
      'VendorCode': instance.vendorCode,
      'VendorName': instance.vendorName,
      'ContactPerson': instance.contactPerson,
      'RefNo': instance.refNo,
      'Address': instance.address,
      'SeriesNamePo': instance.seriesNamePo,
      'SeriesName': instance.seriesName,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'SapReceiptSupplierId': instance.sapReceiptSupplierId,
      'SapReceiptSupplierNo': instance.sapReceiptSupplierNo,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    poId: json['PoId'] as int,
    poLineNo: json['PoLineNo'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    poQty: (json['PoQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    length: (json['Length'] as num)?.toDouble(),
    width: (json['Width'] as num)?.toDouble(),
    weight: (json['Weight'] as num)?.toDouble(),
    unitPriceTc: (json['UnitPriceTc'] as num)?.toDouble(),
    priceTc: (json['PriceTc'] as num)?.toDouble(),
    itemType: json['ItemType'] as String,
    uom: json['Uom'] as String,
    type: json['Type'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    isAsset: json['IsAsset'] as String,
    isBatch: json['IsBatch'] as String,
    priceMode: json['PriceMode'] as String,
    batchNo: json['BatchNo'] as String,
  )..micron = (json['Micron'] as num)?.toDouble();
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'PoId': instance.poId,
      'PoLineNo': instance.poLineNo,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'PoQty': instance.poQty,
      'Qty': instance.qty,
      'Length': instance.length,
      'Width': instance.width,
      'Weight': instance.weight,
      'Micron': instance.micron,
      'UnitPriceTc': instance.unitPriceTc,
      'PriceTc': instance.priceTc,
      'ItemType': instance.itemType,
      'Uom': instance.uom,
      'Type': instance.type,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'IsAsset': instance.isAsset,
      'IsBatch': instance.isBatch,
      'PriceMode': instance.priceMode,
      'BatchNo': instance.batchNo,
    };
